# Lubit Growth Studio

Lubit Growth Studio é a base operacional de uma agência de marketing digital real executada com Paperclip + Codex.

## Objetivo do workspace

- concentrar a operação da agência em uma estrutura clara e reutilizável
- separar direção, pesquisa, estratégia, produção, QA e camada técnica
- manter o trabalho de cada cliente organizado em `clients/{client-name}/`
- permitir que novos projetos sejam iniciados sem reinventar processo

## Agentes oficiais da agência

- `CEO`
- `Strategy Director`
- `Market Researcher`
- `Copywriter`
- `Paid Media Specialist`
- `Content Strategist`
- `Landing Page Builder`
- `Analyst`
- `QA Editor`
- `CTO`

As instruções oficiais de cada papel ficam em `agents/`.

## Regras operacionais

- Esta agência atende clientes reais; não invente fatos, credenciais ou resultados.
- Todo documento deve separar `Fatos confirmados`, `Hipóteses` e `Recomendações` quando houver risco de inferência.
- Nenhum entregável é considerado final sem revisão do `QA Editor`.
- O `CTO` cuida apenas da parte técnica, documentação, automações e organização do repositório.
- Nomes antigos como `CMO` e `CMO 2` podem existir no histórico, mas não são papéis oficiais desta versão base.

## Estrutura principal

- `agency/`: sistema operacional, governança e documentação central
- `agents/`: instruções oficiais por papel
- `workflows/`: passos operacionais repetíveis
- `templates/`: modelos de entregáveis
- `clients/`: trabalho por cliente
- `output/`: saídas temporárias ou consolidadas

## Cliente de teste preservado

O cliente `clients/clinica-sorriso-local/` foi mantido como ambiente de teste da operação.

Arquivos já existentes preservados:

- `clients/clinica-sorriso-local/brief.md`
- `clients/clinica-sorriso-local/reports/ceo-initial-plan.md`

## Como usar

1. Crie ou atualize o cliente em `clients/{client-name}/`.
2. Siga o workflow adequado em `workflows/`.
3. Use os modelos em `templates/`.
4. Produza os arquivos nas subpastas corretas do cliente.
5. Envie para revisão de `QA` antes de marcar como pronto.

## Documentos-chave

- `AGENTS.md`
- `agency/operating-system.md`
- `agency/org-structure.md`
- `agency/file-structure.md`
- `agency/quality-bar.md`
- `agency/handoff-protocol.md`
- `agency/cleanup-notes.md`
- `agency/next-actions.md`
