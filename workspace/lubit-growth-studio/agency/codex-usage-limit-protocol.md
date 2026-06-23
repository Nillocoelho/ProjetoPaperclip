# Protocolo para Limites de Codex e ChatGPT

## Objetivo

Definir a resposta padrão quando a execução falhar por limite de uso, autenticação, crédito, quota, modelo indisponível ou falha de adaptador.

## Erros cobertos

Quando houver erro de:

- `usage limit reached`
- `rate limit reached`
- `quota exceeded`
- `limit reset`
- `no credits available`
- `insufficient credits`
- `Codex limit`
- `ChatGPT limit`
- `subscription limit`
- `model unavailable`
- `authentication expired`
- `login required`
- `adapter failure`

o agente deve seguir este protocolo.

## Resposta obrigatória

O agente deve:

1. parar execução
2. não repetir retries
3. não criar tarefa duplicada
4. registrar erro exato
5. registrar progresso salvo
6. registrar o que falta
7. marcar `waiting` ou `blocked` quando possível
8. escalar para `Runtime Supervisor`
9. escalar para `CTO` se for técnico
10. escalar para `CEO` se precisar decisão operacional

## Registro mínimo

Todo registro deve incluir:

- tarefa afetada
- agente afetado
- mensagem exata do erro
- último arquivo salvo ou validado
- progresso real encontrado
- pendência restante
- risco operacional
- owner recomendado

## O que não fazer

- não insistir em retries automáticos
- não abrir subtarefa duplicada para tentar o mesmo passo
- não marcar como concluído sem saída válida
- não ocultar o erro com comentário genérico

## Handoff recomendado

```text
Evento: usage limit ou falha equivalente
Tarefa afetada: {nome}
Agente afetado: {papel}
Erro exato: {mensagem}
Progresso salvo: {o que ficou preservado}
O que falta: {pendência}
Status recomendado: {waiting | blocked}
Escalonamento: {Runtime Supervisor | CTO | CEO}
```

## Regra operacional

Limite de uso, login expirado e adaptador falhando não são convite para mais retries. São gatilhos de pausa, registro e escalonamento correto.
