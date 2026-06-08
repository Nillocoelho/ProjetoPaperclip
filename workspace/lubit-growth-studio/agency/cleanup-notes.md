# Notas de Limpeza e Padronização

## Escopo desta limpeza

Esta organização atuou apenas no sistema de arquivos e na documentação do workspace.

Não foram alterados:

- banco de dados do Paperclip
- dados internos da aplicação
- containers Docker
- arquivos técnicos fora da documentação da agência
- brief e entregáveis já existentes da `clinica-sorriso-local`

## Agentes oficiais desta base

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

## Nomes antigos ou duplicados a evitar

- `CMO`
- `CMO 2`
- variações de liderança que repitam direção já coberta por `CEO` ou `Strategy Director`

## Por que `CMO` e `CMO 2` não devem ser usados como papéis principais agora

- O papel de direção executiva já está coberto pelo `CEO`.
- A coordenação estratégica e operacional de marketing já está coberta pelo `Strategy Director`.
- Manter `CMO` ou `CMO 2` como título oficial criaria dúvida sobre quem decide prioridade, posicionamento e aprovação.
- Quando existe ambiguidade de liderança, a operação perde velocidade e aumenta retrabalho.

## Como criar novas funções no futuro

Antes de criar um novo agente, confirme:

- qual gargalo recorrente ele resolve
- quais entregáveis passam a ser exclusivos desse papel
- quais arquivos esse papel cria ou atualiza
- quem aprova o trabalho dele
- por que o escopo não cabe em um agente oficial já existente

Se a resposta não estiver clara, documente a necessidade como experimento antes de criar o novo papel.

## Decisões sobre o cliente de teste

Foram preservados sem remoção:

- `clients/clinica-sorriso-local/brief.md`
- `clients/clinica-sorriso-local/reports/ceo-initial-plan.md`

A estrutura de pastas do cliente foi mantida e completada para acomodar os próximos entregáveis.

## Próximos passos recomendados para continuar a operação

- revisar os agentes oficiais dentro do Paperclip para refletir esta nomenclatura
- usar `clients/_template/` como base para novos clientes
- iniciar a produção de pesquisa, posicionamento, copy, medição e QA da `clinica-sorriso-local`
- evitar novos documentos fora da estrutura definida sem justificativa operacional
