# Protocolo de Handoff

## Objetivo

Garantir continuidade entre agentes sem perda de contexto, retrabalho ou ambiguidade.

## Formato mínimo

Todo handoff deve conter:

### 1. Objetivo

O que precisa ser entregue a seguir.

### 2. Fatos confirmados

Lista curta do que veio do brief, de pesquisa validada ou de decisão já aprovada.

### 3. Hipóteses

Pontos ainda não confirmados que podem afetar a qualidade do próximo passo.

### 4. Trabalho concluído

Resumo do que já foi produzido.

### 5. Arquivos envolvidos

Lista de arquivos usados, criados ou atualizados.

### 6. Pendências

O que ainda bloqueia ou exige validação.

### 7. Próxima ação recomendada

Quem assume agora e qual deve ser o próximo movimento.

### 8. Owner recomendado

Quem deve assumir formalmente a continuidade: `Runtime Supervisor`, `CTO`, `CEO`, `QA Editor` ou agente de execução.

## Regras

- não passar material solto sem contexto
- não marcar hipótese como decisão
- não pedir QA antes do pacote mínimo estar completo
- não usar handoff para empurrar responsabilidade indefinida

## Regra para incidentes operacionais

Quando um agente detectar problema técnico ou operacional, deve registrar:

- tarefa afetada
- agente afetado
- erro ou padrão observado
- arquivos alterados
- progresso real
- risco
- próxima ação recomendada
- owner recomendado: `Runtime Supervisor`, `CTO`, `CEO` ou `QA Editor`

## Handoff operacional recomendado

```text
Objetivo: estabilizar a execução sem perder o progresso válido.
Tarefa afetada: {nome da tarefa}
Agente afetado: {papel}
Erro ou padrão observado: {mensagem ou comportamento}
Arquivos alterados: {lista curta}
Progresso real: {o que foi salvo}
Risco: {impacto se nada mudar}
Próxima ação recomendada: {ação objetiva}
Owner recomendado: {Runtime Supervisor | CTO | CEO | QA Editor}
```

## Exemplo curto

```text
Objetivo: criar campanha Meta de geração de conversas.
Fatos confirmados: clínica em Fortaleza, verba de R$ 1.500/mês, CTA para WhatsApp.
Hipóteses: equipe responde rápido em horário comercial.
Trabalho concluído: posicionamento e tese de oferta definidos.
Arquivos envolvidos: brief.md, strategy/positioning.md.
Pendências: confirmar permissão de uso dos depoimentos.
Próxima ação recomendada: Copywriter estruturar mensagens e CTA inicial.
Owner recomendado: Copywriter.
```
