# Sistema Operacional da Agência

## Propósito

Transformar demandas de marketing em entregáveis consistentes, auditáveis e reutilizáveis.

## Princípios operacionais

- trabalhar com fatos antes de opinião
- registrar hipóteses sem vendê-las como verdade
- produzir materiais prontos para execução humana
- documentar decisões para evitar retrabalho
- manter cada papel dentro do seu escopo

## Ciclo padrão de trabalho

1. `CEO` prioriza cliente, meta e escopo.
2. `Market Researcher` levanta insumos de audiência, mercado e concorrência.
3. `Strategy Director` transforma insumos em posicionamento, oferta, funil e campanha.
4. `Copywriter` executa o bloco principal de mensagens e copy. Especializações futuras podem ser acionadas quando oficialmente abertas.
5. `QA Editor` revisa o pacote.
6. `CEO` aprova quando o impacto exigir decisão executiva.

## Fluxo de artefatos

- Brief entra em `clients/{client-name}/brief.md`
- Pesquisa entra em `clients/{client-name}/research/`
- Estratégia entra em `clients/{client-name}/strategy/`
- Copy entra em `clients/{client-name}/copy/`
- Estruturas de página entram em `clients/{client-name}/landing-pages/`
- Medição e relatórios entram em `clients/{client-name}/reports/`
- Testes e aprendizados entram em `clients/{client-name}/experiments/`

## Regras de execução

- Um entregável só avança quando o objetivo está claro.
- O agente que produz também registra limites e pendências.
- O próximo agente recebe contexto suficiente para continuar sem reconstruir raciocínio do zero.
- Toda recomendação deve apontar próxima ação, responsável e métrica sempre que possível.

## Runtime Supervision

O `Runtime Supervisor` deve ser acionado quando a operação sair do fluxo normal e entrar em loop, retry improdutivo, erro de limite, falha de adaptador, tarefa travada, login expirado ou duplicação de trabalho.

### Quando o Runtime Supervisor deve ser acionado

- quando houver `recovery needed` sem progresso real
- quando o mesmo erro reaparecer em retries curtos
- quando uma tarefa ficar stranded ou sem owner claro
- quando surgir `adapter_failed`, `usage limit`, `rate limit`, `quota exceeded`, `authentication expired` ou erro equivalente
- quando dois agentes começarem a repetir o mesmo trabalho

### Como o CEO deve usar o Runtime Supervisor

- pedir revisão operacional quando notar churn alto, espera confusa ou muitos handoffs improdutivos
- usar o parecer do `Runtime Supervisor` para decidir repriorização, espera, troca de owner ou encerramento operacional
- evitar solicitar novos retries antes de ler o progresso real consolidado

### Como o CTO deve receber escalonamentos

Escalonamentos para o `CTO` devem chegar com:

- tarefa afetada
- erro exato ou padrão observado
- arquivos alterados
- progresso salvo
- impacto operacional
- próxima ação recomendada

### Como evitar retry loops

- não repetir a mesma ação duas vezes sem nova hipótese operacional
- interromper a sequência quando o erro for de limite, login, crédito ou adaptador
- transformar repetição em decisão: `retry único`, `waiting`, `blocked`, `escalate to CTO` ou `escalate to CEO`

### Como lidar com tarefas quebradas

- salvar o que já foi produzido
- registrar claramente o que falta
- marcar owner recomendado
- encaminhar para `CTO` se for técnico
- encaminhar para `CEO` se depender de prioridade, custo ou decisão operacional

### Como registrar waiting quando o uso do ChatGPT ou Codex estiver esgotado

Registrar:

- erro exato recebido
- hora ou contexto do bloqueio
- progresso salvo
- pendência restante
- status recomendado: `waiting` ou `blocked`
- owner recomendado: `Runtime Supervisor`, `CTO` ou `CEO`

## Cadência recomendada

- semanal: revisão de pipeline por cliente
- quinzenal: leitura de aprendizados e gargalos operacionais
- mensal: revisão de templates, workflows, qualidade média da operação e saúde operacional

## Quando abrir novo papel

Crie um novo papel apenas se todos os critérios abaixo forem verdadeiros:

- existe trabalho recorrente que não cabe mais no papel atual
- há entregáveis específicos para esse novo papel
- a responsabilidade não é uma duplicação de liderança
- a agência consegue explicar claramente entrada, saída e QA desse novo papel
