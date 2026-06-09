# Deploy de Produção na HostGator VPS

Este projeto deve ser hospedado em VPS, não em Shared Hosting.

## Pré-requisitos

- VPS Linux ativa na HostGator
- DNS do domínio apontando para o IP público da VPS
- Acesso SSH com usuário sudo
- Docker Engine e Docker Compose Plugin instalados
- Login do Codex já autenticado no servidor em `./codex-home/auth.json`

## O que sobe em produção

- `postgres`: banco local da stack
- `paperclip`: aplicação Paperclip + Codex CLI
- `caddy`: proxy reverso com HTTPS automático

## Arquivos usados

- `docker-compose.prod.yml`
- `.env.prod`
- `ops/caddy/Caddyfile`

## Estrutura persistente

Os dados que precisam sobreviver a reinícios e upgrades ficam nestes caminhos:

- `paperclip-data/`
- `codex-home/`
- `workspace/`
- `deploy-data/postgres/`
- `deploy-data/caddy/`

## Passo a passo

1. Clone o repositório na VPS.
2. Entre na pasta do projeto.
3. Crie o arquivo `.env.prod` a partir de `.env.prod.example`.
4. Preencha `DOMAIN`, `LETSENCRYPT_EMAIL`, segredos e senha do Postgres.
5. Garanta que o DNS do domínio já aponta para a VPS.
6. Crie os diretórios persistentes:

```bash
mkdir -p deploy-data/postgres
mkdir -p deploy-data/caddy/data
mkdir -p deploy-data/caddy/config
mkdir -p paperclip-data
mkdir -p codex-home
```

7. Ajuste ou copie o `codex-home/auth.json` com a autenticação do Codex que a equipe vai usar.
8. Suba a stack:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml up -d --build
```

9. Verifique o estado dos containers:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml ps
docker compose --env-file .env.prod -f docker-compose.prod.yml logs -f paperclip
docker compose --env-file .env.prod -f docker-compose.prod.yml logs -f caddy
```

10. Depois que a aplicação subir, valide a saúde:

```bash
curl -I https://SEU-DOMINIO
curl https://SEU-DOMINIO/api/health
```

11. Se o Paperclip estiver em modo autenticado/privado e rejeitar o host externo, permita o hostname:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml exec paperclip paperclipai allowed-hostname SEU-DOMINIO
```

## Firewall recomendado

Abra apenas:

- `22/tcp`
- `80/tcp`
- `443/tcp`

Não exponha `5432` nem a porta interna do Paperclip no host.

## Backup mínimo

Faça backup regular de:

- `paperclip-data/`
- `codex-home/`
- `workspace/`
- `deploy-data/postgres/`
- `deploy-data/caddy/`

Backup lógico extra do banco:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml exec postgres \
  pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB" > backup-paperclip.sql
```

## Upgrade

```bash
git pull
docker compose --env-file .env.prod -f docker-compose.prod.yml up -d --build
```

## Smoke test pós-deploy

- abrir `https://SEU-DOMINIO`
- confirmar `GET /api/health`
- confirmar que a empresa esperada foi importada
- criar uma issue simples e validar se um agente acorda
- revisar logs do `paperclip` para erros de auth, rate limit ou adapter
