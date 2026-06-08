#!/bin/sh
set -eu

INSTANCE_ID="${PAPERCLIP_INSTANCE_ID:-default}"
DATA_DIR="${PAPERCLIP_DATA_DIR:-/home/node/paperclip}"
WORKSPACE_DIR="${PAPERCLIP_WORKSPACE_DIR:-/workspace}"
IMPORT_PATH="${PAPERCLIP_IMPORT_PATH:-/workspace/import-package}"
CONFIG_PATH="$DATA_DIR/instances/$INSTANCE_ID/config.json"
APP_PID=""

mkdir -p "$DATA_DIR" "$WORKSPACE_DIR" /home/node/.codex

# Expose the app outside the container while Paperclip stays bound to loopback.
socat TCP-LISTEN:3101,fork,reuseaddr TCP:127.0.0.1:3100 &

start_paperclip() {
  echo "Starting Paperclip instance: $INSTANCE_ID"
  paperclipai run --data-dir "$DATA_DIR" --instance "$INSTANCE_ID" &
  APP_PID="$!"
}

wait_for_server() {
  tries=0
  until wget -q -O /dev/null http://127.0.0.1:3100; do
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

  companies_json="$(paperclipai company list --json 2>/dev/null || printf '[]')"
  printf '%s' "$companies_json" | grep -Eq '^[[:space:]]*\[[[:space:]]*\][[:space:]]*$'
}

if [ ! -f "$CONFIG_PATH" ]; then
  echo "No existing Paperclip instance found; running first-time onboarding."
  paperclipai onboard --yes
fi

start_paperclip
wait_for_server

if should_import_package; then
  echo "Empty Paperclip instance detected; importing package from $IMPORT_PATH"
  paperclipai company import "$IMPORT_PATH" --yes
fi

wait "$APP_PID"
