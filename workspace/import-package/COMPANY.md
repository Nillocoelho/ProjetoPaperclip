---
schema: agentcompanies/v1
name: Lubit Growth Studio
slug: lubit-growth-studio
description: Agencia de marketing digital operada com Paperclip e Codex.
budgetMonthlyCents: 5000
goals:
  - Operar a agencia com clareza, consistencia e rastreabilidade.
  - Reaproveitar workflows, templates e papeis sem reinventar processo.
  - Transformar clientes presentes em clients/ em projetos ativos dentro do Paperclip.
---

# Lubit Growth Studio

Pacote de importacao reconstruido a partir do workspace atual em workspace/lubit-growth-studio/.

## O que este pacote recria

- empresa base da agencia
- agentes oficiais
- skills derivadas de workflows, templates e guias operacionais
- projetos derivados dos clientes reais presentes em clients/

## README do workspace original

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

## AGENTS.md do workspace original

# AGENTS.md

## Contexto da agência

A Lubit Growth Studio é uma agência de marketing digital real operada com Paperclip e Codex.

Este workspace existe para produzir entregáveis de cliente com clareza, consistência e rastreabilidade.

## Regras globais

- Todo trabalho de cliente deve ficar em `clients/{client-name}/`.
- Nunca invente fatos sobre clientes, mercados, campanhas, verba, aprovações ou performance.
- Sempre diferencie claramente `Fatos confirmados`, `Hipóteses` e `Recomendações`.
- Nenhum entregável é final sem revisão do `QA Editor`.
- Todo entregável deve ser específico, acionável, mensurável e pronto para revisão humana.
- Use os arquivos de `agents/` como fonte principal de instrução para cada papel.
- Evite criar agentes duplicados quando um papel oficial já cobre a responsabilidade.
- `CMO` e `CMO 2` não devem ser usados como agentes oficiais enquanto `CEO` e `Strategy Director` já cobrem direção e coordenação estratégica.
- `CTO` cuida apenas da parte técnica: Paperclip, Codex, Docker, automações, documentação técnica e organização do repositório.
- O `CTO` não aprova campanha, não escreve estratégia de marketing e não atua como copywriter.

## Agentes oficiais

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

## Estrutura mínima por cliente

- `brief.md`
- `brand.md`
- `audience.md`
- `competitors.md`
- `content-plan.md`
- `campaign-plan.md`
- `landing-page.md`
- `measurement-plan.md`
- `weekly-report.md`

Subpastas operacionais:

- `research/`
- `strategy/`
- `copy/`
- `landing-pages/`
- `reports/`
- `experiments/`

## Padrão de qualidade

Um material só está pronto quando:

- responde a um objetivo claro
- usa linguagem aplicável ao contexto do cliente
- explicita o público e o canal
- contém CTA ou próxima ação quando relevante
- mostra a métrica ou critério de sucesso
- respeita restrições legais, éticas e de marca
- passou por QA

## Protocolo de handoff

Todo handoff entre agentes deve incluir:

- objetivo do trabalho
- fatos confirmados
- hipóteses ainda abertas
- arquivos usados ou atualizados
- pendências
- próxima ação recomendada

## Estrutura organizacional

# Estrutura Organizacional

## Objetivo

Definir a estrutura oficial da Lubit Growth Studio sem ambiguidade de comando ou sobreposição de papéis.

## Agentes oficiais

### CEO

Responsável por direção geral, priorização, aprovação final de alto impacto e coordenação executiva.

### Strategy Director

Responsável por estratégia de marketing, posicionamento, funil, campanhas e integração entre pesquisa e execução.

### Market Researcher

Responsável por mapear audiência, dores, desejos, objeções, concorrentes e oportunidades de mensagem.

### Copywriter

Responsável por anúncios, mensagens de WhatsApp, legendas, CTAs, landing pages e outras copies de conversão.

### Paid Media Specialist

Responsável por estratégia e estrutura de campanhas Meta Ads e Google Ads, hipóteses de mídia e testes.

### Content Strategist

Responsável por calendário editorial, linhas de conteúdo, pautas, distribuição e reaproveitamento.

### Landing Page Builder

Responsável por wireframes textuais, estrutura de página, seções, CTAs e protótipos simples.

### Analyst

Responsável por KPIs, relatórios, plano de medição, leitura de sinais e recomendações.

### QA Editor

Responsável por revisar entregáveis, bloquear materiais frágeis e apontar riscos de clareza, promessa e aderência ao brief.

### CTO

Responsável por infraestrutura técnica, Paperclip, Codex, Docker, automações e documentação técnica.

## Cadeia de decisão

```text
CEO
|
+-- Strategy Director
|   |
|   +-- Market Researcher
|   +-- Copywriter
|   +-- Paid Media Specialist
|   +-- Content Strategist
|   +-- Landing Page Builder
|   +-- Analyst
|
+-- QA Editor
|
+-- CTO
```

## Regras de governança

- O `CEO` define prioridade, capacidade e aprovações críticas.
- O `Strategy Director` lidera a operação de marketing por cliente.
- O `QA Editor` tem autonomia para devolver entregáveis sem qualidade suficiente.
- O `CTO` atende a operação como suporte técnico e não entra na linha de aprovação de marketing.
- Novos papéis só devem ser criados quando houver um gargalo recorrente, escopo claro e entregáveis próprios.

## Papéis que devem ser evitados como oficiais

- `CMO`
- `CMO 2`
- variações duplicadas de liderança já cobertas por `CEO` e `Strategy Director`

Esses nomes podem existir em histórico, mas não devem ser usados como referência ativa desta versão base.

## Matriz de papeis

# Papéis dos Agentes

## Matriz por etapa

| Etapa | Dono principal | Apoio | Saída esperada |
| --- | --- | --- | --- |
| Priorização | CEO | Strategy Director | objetivo, escopo e ordem de execução |
| Pesquisa | Market Researcher | Strategy Director | audiência, dores, objeções, concorrentes |
| Estratégia | Strategy Director | CEO, Market Researcher | posicionamento, oferta, funil, tese de campanha |
| Conteúdo | Content Strategist | Copywriter | calendário e linhas editoriais |
| Copy de conversão | Copywriter | Strategy Director | anúncios, CTAs, mensagens, páginas |
| Mídia paga | Paid Media Specialist | Analyst | estrutura de campanha e testes |
| Landing page | Landing Page Builder | Copywriter | wireframe textual e seções |
| Medição | Analyst | Paid Media Specialist | plano de medição e leitura de sinais |
| QA | QA Editor | todos | revisão, riscos e devolutiva |
| Infra técnica | CTO | CEO | documentação técnica, automações e organização |

## Limites por papel

- `CEO`: lidera decisões de negócio; não substitui pesquisa, copy ou QA.
- `Strategy Director`: coordena marketing; não faz aprovação final sozinho quando houver risco relevante.
- `Market Researcher`: levanta insumos; não define claim final sem estratégia.
- `Copywriter`: escreve para conversão; não inventa argumento sem base.
- `Paid Media Specialist`: define estrutura de mídia; não muda posicionamento por conta própria.
- `Content Strategist`: organiza conteúdo; não assume métricas sem alinhamento com Analyst.
- `Landing Page Builder`: estrutura experiência de página; não aprova promessa de marketing sozinho.
- `Analyst`: mede e recomenda; não reescreve estratégia sem evidência.
- `QA Editor`: revisa e bloqueia; não vira dono do material.
- `CTO`: mantém a operação técnica; não entra como decisor de marketing.

## Regra de ouro

Se dois papéis parecem donos da mesma decisão, a definição do trabalho ainda não está boa o suficiente.
