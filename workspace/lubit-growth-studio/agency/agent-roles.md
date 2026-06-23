# Papéis dos Agentes

## Matriz por etapa

| Etapa | Dono principal | Apoio | Saída esperada |
| --- | --- | --- | --- |
| Priorização e decisão final | CEO | Strategy Director, CTO, Runtime Supervisor | objetivo, escopo, prioridade e decisão executiva |
| Estratégia de marketing | Strategy Director | CEO, Market Researcher | posicionamento, oferta, funil e tese de campanha |
| Pesquisa de audiência e mercado | Market Researcher | Strategy Director | audiência, dores, objeções, concorrentes e insumos |
| Copy e mensagens | Copywriter | Strategy Director | anúncios, CTAs, mensagens e estrutura de página |
| Qualidade final | QA Editor | todos | revisão, riscos, bloqueio ou aprovação |
| Infraestrutura técnica | CTO | CEO, Runtime Supervisor | documentação técnica, automações, repositório e ambiente |
| Saúde operacional | Runtime Supervisor | CEO, CTO | triagem de incidentes, bloqueio de loop, handoff e escalonamento |

## Agentes oficiais atuais

- `CEO`: dono da operação, prioridades e decisões finais.
- `Strategy Director`: dono da estratégia de marketing.
- `Market Researcher`: dono da pesquisa de audiência e mercado.
- `Copywriter`: dono das copies e mensagens.
- `QA Editor`: dono da qualidade dos entregáveis.
- `CTO`: dono da infraestrutura técnica, Paperclip, Codex, Docker, repositório, automações e documentação técnica.
- `Runtime Supervisor`: dono da saúde operacional, loops, recovery, high churn, stranded tasks, usage limits, adapter failures e tarefas duplicadas.

## Especializações futuras

Os papéis abaixo continuam válidos como especializações futuras da agência, mas não fazem parte do núcleo oficial atual:

- `Paid Media Specialist`
- `Content Strategist`
- `Landing Page Builder`
- `Analyst`

## Limites por papel

- `CEO`: lidera decisões de negócio; não substitui pesquisa, copy ou QA.
- `Strategy Director`: coordena marketing; não assume operação técnica ou fiscalização de runtime.
- `Market Researcher`: levanta insumos; não define claim final sem estratégia.
- `Copywriter`: escreve para conversão; não inventa argumento sem base.
- `QA Editor`: revisa e bloqueia; não vira dono do material nem monitor de loop.
- `CTO`: mantém a operação técnica; não entra como decisor de marketing nem como monitor contínuo de incidentes operacionais.
- `Runtime Supervisor`: fiscaliza a operação; não cria estratégia, não escreve copy, não faz QA final e não substitui o `CTO`.

## Regra de ouro

Se dois papéis parecem donos da mesma decisão, a definição do trabalho ainda não está boa o suficiente.
