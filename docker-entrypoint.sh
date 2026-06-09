#!/bin/sh
set -eu

INSTANCE_ID="${PAPERCLIP_INSTANCE_ID:-default}"
DATA_DIR="${PAPERCLIP_DATA_DIR:-/home/node/paperclip}"
WORKSPACE_DIR="${PAPERCLIP_WORKSPACE_DIR:-/workspace}"
IMPORT_PATH="${PAPERCLIP_IMPORT_PATH:-/workspace/import-package}"
CONFIG_PATH="$DATA_DIR/instances/$INSTANCE_ID/config.json"
LOCAL_API_BASE="http://127.0.0.1:3100"
COMPANY_BUDGET_CENTS="${PAPERCLIP_COMPANY_BUDGET_CENTS:-5000}"
LEAD_AGENT_BUDGET_CENTS="${PAPERCLIP_LEAD_AGENT_BUDGET_CENTS:-700}"
EXEC_AGENT_BUDGET_CENTS="${PAPERCLIP_EXEC_AGENT_BUDGET_CENTS:-300}"
BUDGET_WARN_PERCENT="${PAPERCLIP_BUDGET_WARN_PERCENT:-70}"
BUDGET_HARD_STOP_ENABLED="${PAPERCLIP_BUDGET_HARD_STOP_ENABLED:-true}"
APP_PID=""

mkdir -p "$DATA_DIR" "$WORKSPACE_DIR" /home/node/.codex

# Expose the app outside the container while Paperclip stays bound to loopback.
socat TCP-LISTEN:3101,fork,reuseaddr TCP:127.0.0.1:3100 &

start_paperclip() {
  if [ -f "$CONFIG_PATH" ]; then
    echo "Starting Paperclip instance: $INSTANCE_ID"
    paperclipai run --data-dir "$DATA_DIR" --instance "$INSTANCE_ID" &
  else
    echo "Bootstrapping new Paperclip instance: $INSTANCE_ID"
    paperclipai onboard --yes --data-dir "$DATA_DIR" &
  fi

  APP_PID="$!"
}

wait_for_server() {
  tries=0
  until wget -q -O /dev/null "$LOCAL_API_BASE/api/health"; do
    tries=$((tries + 1))
    if [ "$tries" -ge 60 ]; then
      echo "Paperclip did not become ready in time."
      exit 1
    fi
    sleep 2
  done
}

should_import_package() {
  [ -f "$IMPORT_PATH/COMPANY.md" ] || return 1

  companies_json="$(paperclipai company list --api-base "$LOCAL_API_BASE" --json 2>/dev/null || printf '[]')"
  printf '%s' "$companies_json" | grep -Eq '^[[:space:]]*\[[[:space:]]*\][[:space:]]*$'
}

normalize_codex_agents() {
  if ! command -v psql >/dev/null 2>&1; then
    echo "psql client not available; skipping agent runtime normalization."
    return
  fi

  if [ -z "${DATABASE_URL:-}" ]; then
    echo "DATABASE_URL is not set; skipping agent runtime normalization."
    return
  fi

  echo "Normalizing company and codex_local agent budgets, heartbeat, and cheap profile."
  psql "$DATABASE_URL" <<SQL
UPDATE companies
SET budget_monthly_cents = ${COMPANY_BUDGET_CENTS},
    updated_at = NOW();

UPDATE agents
SET budget_monthly_cents = CASE
      WHEN role IN ('ceo', 'cto', 'cmo') THEN ${LEAD_AGENT_BUDGET_CENTS}
      ELSE ${EXEC_AGENT_BUDGET_CENTS}
    END,
    updated_at = NOW()
WHERE adapter_type = 'codex_local';

UPDATE agents
SET runtime_config = jsonb_set(
  jsonb_set(
    COALESCE(runtime_config, '{}'::jsonb),
    '{heartbeat}',
    '{"enabled":true,"intervalSec":0,"wakeOnAssignment":true,"wakeOnOnDemand":true,"wakeOnAutomation":false,"maxConcurrentRuns":1}'::jsonb,
    true
  ),
  '{modelProfiles}',
  COALESCE(runtime_config->'modelProfiles', '{}'::jsonb) || '{"cheap":{"enabled":true,"label":"Codex 5.4 Cheapest","adapterConfig":{"extraArgs":["--profile","cheap"]}}}'::jsonb,
  true
)
WHERE adapter_type = 'codex_local';

INSERT INTO budget_policies (
  company_id,
  scope_type,
  scope_id,
  metric,
  window_kind,
  amount,
  warn_percent,
  hard_stop_enabled,
  notify_enabled,
  is_active,
  created_at,
  updated_at
)
SELECT
  c.id,
  'company',
  c.id,
  'billed_cents',
  'calendar_month_utc',
  ${COMPANY_BUDGET_CENTS},
  ${BUDGET_WARN_PERCENT},
  ${BUDGET_HARD_STOP_ENABLED},
  true,
  true,
  NOW(),
  NOW()
FROM companies c
ON CONFLICT (company_id, scope_type, scope_id, metric, window_kind)
DO UPDATE SET
  amount = EXCLUDED.amount,
  warn_percent = EXCLUDED.warn_percent,
  hard_stop_enabled = EXCLUDED.hard_stop_enabled,
  notify_enabled = EXCLUDED.notify_enabled,
  is_active = true,
  updated_at = NOW();

INSERT INTO budget_policies (
  company_id,
  scope_type,
  scope_id,
  metric,
  window_kind,
  amount,
  warn_percent,
  hard_stop_enabled,
  notify_enabled,
  is_active,
  created_at,
  updated_at
)
SELECT
  a.company_id,
  'agent',
  a.id,
  'billed_cents',
  'calendar_month_utc',
  CASE
    WHEN a.role IN ('ceo', 'cto', 'cmo') THEN ${LEAD_AGENT_BUDGET_CENTS}
    ELSE ${EXEC_AGENT_BUDGET_CENTS}
  END,
  ${BUDGET_WARN_PERCENT},
  ${BUDGET_HARD_STOP_ENABLED},
  true,
  true,
  NOW(),
  NOW()
FROM agents a
WHERE a.adapter_type = 'codex_local'
ON CONFLICT (company_id, scope_type, scope_id, metric, window_kind)
DO UPDATE SET
  amount = EXCLUDED.amount,
  warn_percent = EXCLUDED.warn_percent,
  hard_stop_enabled = EXCLUDED.hard_stop_enabled,
  notify_enabled = EXCLUDED.notify_enabled,
  is_active = true,
  updated_at = NOW();
SQL
}

start_paperclip
wait_for_server

if should_import_package; then
  echo "Empty Paperclip instance detected; importing package from $IMPORT_PATH"
  paperclipai company import "$IMPORT_PATH" --api-base "$LOCAL_API_BASE" --yes
fi

normalize_codex_agents

wait "$APP_PID"
