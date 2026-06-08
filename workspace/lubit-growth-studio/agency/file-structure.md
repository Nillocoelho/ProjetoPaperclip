# Estrutura de Arquivos

## Visão geral

```text
lubit-growth-studio/
├── AGENTS.md
├── README.md
├── agency/
├── agents/
├── workflows/
├── templates/
├── clients/
│   ├── _template/
│   └── clinica-sorriso-local/
└── output/
```

## Uso de cada pasta

### `agency/`

Documentação de governança, padrões e decisões operacionais da agência.

### `agents/`

Instruções oficiais por papel. Cada arquivo explica escopo, entradas, saídas, limites e checklist.

### `workflows/`

Procedimentos repetíveis para executar tarefas comuns sem depender de memória informal.

### `templates/`

Modelos reutilizáveis para briefs, pesquisas, campanhas, QA, relatórios e planos.

### `clients/`

Área principal de operação por cliente.

### `clients/_template/`

Base para novos clientes. Serve como checklist estrutural, não como conteúdo final.

### `clients/{client-name}/research/`

Pesquisas de audiência, concorrentes, categorias e sinais de mercado.

### `clients/{client-name}/strategy/`

Posicionamento, mensagens centrais, tese de campanha, prioridades e plano tático.

### `clients/{client-name}/copy/`

Anúncios, mensagens, roteiros, legendas e CTAs.

### `clients/{client-name}/landing-pages/`

Wireframes, estrutura de seções, títulos, provas e fluxo de conversão.

### `clients/{client-name}/reports/`

QA, relatórios, retro de campanha e leitura de performance.

### `clients/{client-name}/experiments/`

Hipóteses, testes, resultados e aprendizados.

### `output/`

Saídas consolidadas, pacotes exportáveis ou artefatos temporários da operação. Não substitui a pasta do cliente.

## Convenções

- nomes de clientes em `kebab-case`
- um documento por objetivo principal
- evitar arquivos genéricos como `final.md`, `novo.md` ou `teste2.md`
- preferir nomes descritivos como `meta-ads-offer-test.md`
