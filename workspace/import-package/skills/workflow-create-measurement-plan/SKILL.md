---
name: workflow-create-measurement-plan
slug: workflow-create-measurement-plan
description: Workflow imported from workflows/create-measurement-plan.md
tags:
  - workflow
---

Arquivo de origem: workflows/create-measurement-plan.md

# Workflow: Criar Plano de Medição

## Objetivo

Definir como a agência vai medir progresso, qualidade do lead e sinais de otimização.

## Dono principal

`Analyst`

## Entradas

- objetivo do cliente
- campanha ou canal
- dados disponíveis
- capacidade operacional do cliente

## Passos

1. Definir KPI principal.
2. Definir métricas secundárias e sinais de risco.
3. Mapear origem dos dados.
4. Registrar frequência de leitura.
5. Sugerir decisões possíveis com base no plano.

## Saída recomendada

- `clients/{client-name}/measurement-plan.md`

## QA mínimo

- métricas respondem ao objetivo
- coleta é viável
- existe plano de ação associado às leituras
