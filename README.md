# Paperclip Agencia (LUBIT GROWTH)

Base Docker para operar a Lubit Growth Studio com `paperclipai`, Codex, Postgres e um workspace versionado.

## Estrutura

- `docker-compose.yml`: sobe Postgres e Paperclip
- `docker-compose.prod.yml`: stack de producao com Caddy + HTTPS
- `Dockerfile`: imagem do Paperclip/Codex
- `docs/HOSTGATOR_VPS_DEPLOY.md`: guia exato de deploy na VPS
- `ops/caddy/Caddyfile`: proxy reverso HTTPS
- `workspace/`: operacao da agencia, agentes, workflows, templates e clientes
- `paperclip-data/`: estado local do Paperclip
- `codex-home/`: estado local do Codex

## Setup rapido

1. Copie `.env.example` para `.env`.
2. Preencha os segredos obrigatorios.
3. Revise as portas publicadas, se necessario.
4. Rode `docker compose up -d --build`.
5. O bootstrap do container vai importar automaticamente `workspace/import-package/` se a instancia estiver vazia.

## Variaveis importantes

- `BETTER_AUTH_SECRET`
- `PAPERCLIP_AGENT_JWT_SECRET`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `POSTGRES_DB`
- `POSTGRES_PORT`
- `PAPERCLIP_PORT`
- `DATABASE_URL`

## Notas de operacao

- O container `paperclip` depende do Postgres saudavel antes de iniciar.
- O workspace operacional principal esta em `workspace/lubit-growth-studio/`.
- O pacote importavel que alimenta o bootstrap fica em `workspace/import-package/`.
- Para regenerar esse pacote a partir das pastas atuais do projeto, rode `powershell -ExecutionPolicy Bypass -File .\scripts\rebuild-import-package.ps1`.
- Os agentes importados usam `codex_local` com `--dangerously-bypass-approvals-and-sandbox` para evitar falha de `bwrap` em ambientes Docker/VPS sem user namespaces habilitados.
- A politica de wakeup recomendada para a equipe e `wakeOnAssignment=true` e `wakeOnOnDemand=true`; na instancia atual isso foi aplicado diretamente no banco.
- O `codex-home/config.toml` define o modelo padrao como `gpt-5.4`.
- O `codex-home/cheap.config.toml` define o perfil barato como `gpt-5.4-nano`.
- `paperclip-data/` e `codex-home/` sao dados locais e nao devem ser versionados.

## Hospedagem na HostGator

- Para este projeto, considere apenas VPS ou Dedicated. Shared hosting nao e apropriado para Docker + Paperclip + agentes locais.
- Em VPS, voce sera responsavel por backups, restauracao, atualizacoes e operacao do Docker.
- Garanta persistencia de `paperclip-data/`, `codex-home/` e do volume do Postgres.
- Planeje um proxy reverso com HTTPS na frente da porta publicada do Paperclip.
- Valide previamente o login/credito do Codex no ambiente final, porque limite de uso da conta pode bloquear os agentes mesmo com a infraestrutura correta.
- O pacote de producao preparado neste repositorio usa `docker-compose.prod.yml` + Caddy e esta documentado em `docs/HOSTGATOR_VPS_DEPLOY.md`.

## Checklist pre-lancamento

- trocar segredos e credenciais default
- validar acesso externo e portas publicadas
- revisar o fluxo real de backup do Postgres e de `paperclip-data/`
- confirmar se o onboarding automatico do container esta adequado ao seu uso em producao
- fechar o primeiro pacote completo do cliente com pesquisa, estrategia, copy, medicao e QA
