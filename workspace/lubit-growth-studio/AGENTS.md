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
- `QA Editor`
- `CTO`
- `Runtime Supervisor`

## Runtime Supervisor and Operational Safety

- `Runtime Supervisor` é agente oficial da Lubit Growth Studio.
- O `Runtime Supervisor` fiscaliza saúde operacional, loops, retries improdutivos, stranded tasks, usage limits, adapter failures e duplicação de tarefas.
- Agentes devem escalar para o `Runtime Supervisor` em caso de `recovery needed`, `high churn`, `stranded task`, `adapter failure`, `usage limit`, `login expired`, erro de modelo duplicado ou tarefa duplicada.
- Nenhum agente deve ficar tentando em loop quando não há progresso real.
- Nenhum agente deve criar subtarefas duplicadas para contornar erro técnico.
- Decisões técnicas vão para o `CTO`.
- Decisões operacionais vão para o `CEO`.
- Qualidade final vai para o `QA Editor`.

## Especializações futuras

- `Paid Media Specialist`
- `Content Strategist`
- `Landing Page Builder`
- `Analyst`

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
- owner recomendado
