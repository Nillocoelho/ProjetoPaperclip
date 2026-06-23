# Estrutura Organizacional

## Objetivo

Definir a estrutura oficial da Lubit Growth Studio sem ambiguidade de comando ou sobreposição de papéis.

## Agentes oficiais atuais

### CEO

Responsável por direção geral, priorização, aprovação final de alto impacto e coordenação executiva.

### Strategy Director

Responsável por estratégia de marketing, posicionamento, funil, campanhas e integração entre pesquisa e execução.

### Market Researcher

Responsável por mapear audiência, dores, desejos, objeções, concorrentes e oportunidades de mensagem.

### Copywriter

Responsável por anúncios, mensagens de WhatsApp, legendas, CTAs, landing pages e outras copies de conversão.

### QA Editor

Responsável por revisar entregáveis, bloquear materiais frágeis e apontar riscos de clareza, promessa e aderência ao brief.

### CTO

Responsável por infraestrutura técnica, Paperclip, Codex, Docker, automações e documentação técnica.

### Runtime Supervisor

Responsável por fiscalizar a saúde operacional da agência, detectar loops, retries improdutivos, stranded tasks, adapter failures, limites de uso e duplicação de tarefas.

## Cadeia de decisão

```text
CEO
├── Strategy Director
├── Market Researcher
├── Copywriter
├── QA Editor
├── CTO
└── Runtime Supervisor
```

## Agentes futuros

- `Paid Media Specialist`
- `Content Strategist`
- `Landing Page Builder`
- `Analyst`

## Relação entre Runtime Supervisor, CTO e CEO

- O `Runtime Supervisor` detecta incidentes, consolida evidências e recomenda a próxima ação.
- O `CTO` corrige problemas técnicos de Paperclip, Codex, Docker, adaptadores, automações e repositório.
- O `CEO` decide prioridades, conflitos operacionais, espera, custo e encerramento de tarefas quando houver impacto de negócio.

## Regras de governança

- O `CEO` define prioridade, capacidade e aprovações críticas.
- O `Strategy Director` lidera a operação de marketing por cliente.
- O `QA Editor` tem autonomia para devolver entregáveis sem qualidade suficiente.
- O `CTO` atende a operação como suporte técnico e não entra na linha de aprovação de marketing.
- O `Runtime Supervisor` não substitui o `CTO`; ele detecta e recomenda.
- Novos papéis só devem ser criados quando houver um gargalo recorrente, escopo claro e entregáveis próprios.

## Papéis que devem ser evitados como oficiais

- `CMO`
- `CMO 2`
- variações duplicadas de liderança já cobertas por `CEO` e `Strategy Director`

Esses nomes podem existir em histórico, mas não devem ser usados como referência ativa desta versão base.
