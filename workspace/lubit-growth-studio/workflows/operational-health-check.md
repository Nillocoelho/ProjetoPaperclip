# Workflow: Operational Health Check

## Objetivo

Revisar a saúde operacional da agência para detectar loops, retries improdutivos, stranded tasks, adapter failures, limites de uso e duplicação de trabalho.

## Quando rodar

- quando houver `high churn` ou `recovery needed` recorrente
- quando uma tarefa travar sem owner claro
- quando Codex, ChatGPT ou adaptadores bloquearem a execução
- na revisão operacional periódica da agência

## Agente responsável

`Runtime Supervisor`

## Entradas

- handoffs recentes
- tarefas ativas ou bloqueadas
- comentários de erro ou recovery
- arquivos alterados no ciclo
- registros de limite, login, quota ou adapter failure

## Saídas

- diagnóstico operacional consolidado
- lista de incidentes e riscos
- owner recomendado por incidente
- decisão de `retry`, `waiting`, `blocked`, `escalate to CTO`, `escalate to CEO` ou `send to QA`

## Checklist

1. Confirmar quais tarefas estão ativas, bloqueadas ou sem owner.
2. Identificar retries repetidos sem progresso real.
3. Verificar se houve erro de uso, autenticação, quota ou modelo.
4. Mapear falhas de adaptador, recovery spam e heartbeat loop.
5. Conferir se existem tarefas duplicadas ou subtarefas equivalentes.
6. Registrar quais arquivos realmente avançaram.
7. Definir owner recomendado e próxima ação para cada incidente.

## Template de resultado

- usar `templates/operational-health-check.md`

## Quando escalar para CTO

- quando houver `adapter_failed`
- quando o ambiente técnico impedir continuidade
- quando Paperclip, Codex, Docker, automações ou repositório exigirem correção

## Quando escalar para CEO

- quando a tarefa depender de repriorização
- quando houver conflito de owner ou capacidade
- quando a agência precisar decidir esperar, encerrar ou trocar de rota operacional
