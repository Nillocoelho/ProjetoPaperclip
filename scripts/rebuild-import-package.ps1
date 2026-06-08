param(
  [string]$WorkspaceRoot = (Join-Path $PSScriptRoot "..\workspace\lubit-growth-studio"),
  [string]$OutputRoot = (Join-Path $PSScriptRoot "..\workspace\import-package")
)

$ErrorActionPreference = "Stop"

function Resolve-FullPath {
  param([string]$Path)
  return [System.IO.Path]::GetFullPath($Path)
}

function Ensure-Directory {
  param([string]$Path)
  New-Item -ItemType Directory -Path $Path -Force | Out-Null
}

function Write-Utf8File {
  param(
    [string]$Path,
    [string]$Content
  )

  $directory = Split-Path -Parent $Path
  if ($directory) {
    Ensure-Directory -Path $directory
  }

  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content.TrimEnd() + [Environment]::NewLine, $encoding)
}

function Read-SourceFile {
  param([string]$Path)
  if ([string]::IsNullOrWhiteSpace($Path)) {
    $stack = (Get-PSCallStack | Select-Object -Skip 1 -First 3 | ForEach-Object { $_.Location }) -join " | "
    throw "Read-SourceFile received an empty path. Stack: $stack"
  }
  return Get-Content -LiteralPath $Path -Raw
}

function Format-Bullets {
  param([string[]]$Items)

  if (-not $Items -or $Items.Count -eq 0) {
    return "- none"
  }

  return ($Items | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}

function New-MarkdownDocument {
  param(
    [string[]]$FrontmatterLines,
    [string]$Body
  )

  $parts = @()
  if ($FrontmatterLines -and $FrontmatterLines.Count -gt 0) {
    $parts += "---"
    $parts += $FrontmatterLines
    $parts += "---"
    $parts += ""
  }
  $parts += $Body.Trim()
  return ($parts -join [Environment]::NewLine)
}

function Get-SlugName {
  param([string]$Name)

  return ($Name -replace "[^a-z0-9]+", "-").Trim("-")
}

function Get-TitleCaseName {
  param([string]$Slug)

  $normalized = $Slug -replace "-", " "
  return (Get-Culture).TextInfo.ToTitleCase($normalized)
}

$workspaceRoot = Resolve-FullPath -Path $WorkspaceRoot
$outputRoot = Resolve-FullPath -Path $OutputRoot

if (-not (Test-Path $workspaceRoot)) {
  throw "Workspace not found: $workspaceRoot"
}

if (Test-Path $outputRoot) {
  Remove-Item -LiteralPath $outputRoot -Recurse -Force
}

Ensure-Directory -Path $outputRoot

$agentMetadata = @{
  "ceo" = @{
    Name = "CEO"
    Title = "Chief Executive Officer"
    Role = "ceo"
    ReportsTo = $null
    Skills = @("workflow-onboard-client", "guide-next-actions", "guide-operating-system")
  }
  "strategy-director" = @{
    Name = "Strategy Director"
    Title = "Strategy Director"
    Role = "cmo"
    ReportsTo = "ceo"
    Skills = @("workflow-create-positioning", "workflow-create-campaign", "guide-handoff-protocol", "template-positioning")
  }
  "market-researcher" = @{
    Name = "Market Researcher"
    Title = "Market Researcher"
    Role = "researcher"
    ReportsTo = "strategy-director"
    Skills = @("workflow-create-audience-research", "template-audience-research", "client-template-competitors")
  }
  "copywriter" = @{
    Name = "Copywriter"
    Title = "Copywriter"
    ReportsTo = "strategy-director"
    Skills = @("workflow-create-campaign", "workflow-create-landing-page", "template-meta-ads", "template-whatsapp-messages")
  }
  "paid-media-specialist" = @{
    Name = "Paid Media Specialist"
    Title = "Paid Media Specialist"
    ReportsTo = "strategy-director"
    Skills = @("workflow-create-campaign", "template-meta-ads", "template-measurement-plan")
  }
  "content-strategist" = @{
    Name = "Content Strategist"
    Title = "Content Strategist"
    ReportsTo = "strategy-director"
    Skills = @("workflow-create-content-plan", "template-instagram-content-plan", "client-template-content-plan")
  }
  "landing-page-builder" = @{
    Name = "Landing Page Builder"
    Title = "Landing Page Builder"
    ReportsTo = "strategy-director"
    Skills = @("workflow-create-landing-page", "template-landing-page", "client-template-landing-page")
  }
  "analyst" = @{
    Name = "Analyst"
    Title = "Analyst"
    ReportsTo = "strategy-director"
    Skills = @("workflow-create-measurement-plan", "template-measurement-plan", "template-weekly-report")
  }
  "qa-editor" = @{
    Name = "QA Editor"
    Title = "QA Editor"
    Role = "qa"
    ReportsTo = "ceo"
    Skills = @("workflow-qa-review", "template-qa-review", "guide-quality-bar")
  }
  "cto" = @{
    Name = "CTO"
    Title = "Chief Technology Officer"
    Role = "cto"
    ReportsTo = "ceo"
    Skills = @("guide-file-structure", "guide-cleanup-notes", "guide-operating-system")
  }
}

$skillSources = @()

Get-ChildItem -LiteralPath (Join-Path $workspaceRoot "agency") -Filter "*.md" | Sort-Object Name | ForEach-Object {
  $skillSources += @{
    Slug = "guide-$($_.BaseName.ToLowerInvariant())"
    Name = "guide-$($_.BaseName.ToLowerInvariant())"
    Description = "Operational guide imported from agency/$($_.Name)"
    SourcePath = $_.FullName
    RelativePath = "agency/$($_.Name)"
    Tags = @("guide", "agency")
  }
}

Get-ChildItem -LiteralPath (Join-Path $workspaceRoot "workflows") -Filter "*.md" | Sort-Object Name | ForEach-Object {
  $skillSources += @{
    Slug = "workflow-$($_.BaseName.ToLowerInvariant())"
    Name = "workflow-$($_.BaseName.ToLowerInvariant())"
    Description = "Workflow imported from workflows/$($_.Name)"
    SourcePath = $_.FullName
    RelativePath = "workflows/$($_.Name)"
    Tags = @("workflow")
  }
}

Get-ChildItem -LiteralPath (Join-Path $workspaceRoot "templates") -Filter "*.md" | Sort-Object Name | ForEach-Object {
  $skillSources += @{
    Slug = "template-$($_.BaseName.ToLowerInvariant())"
    Name = "template-$($_.BaseName.ToLowerInvariant())"
    Description = "Reusable template imported from templates/$($_.Name)"
    SourcePath = $_.FullName
    RelativePath = "templates/$($_.Name)"
    Tags = @("template")
  }
}

Get-ChildItem -LiteralPath (Join-Path $workspaceRoot "clients\_template") -Filter "*.md" | Sort-Object Name | ForEach-Object {
  $skillSources += @{
    Slug = "client-template-$($_.BaseName.ToLowerInvariant())"
    Name = "client-template-$($_.BaseName.ToLowerInvariant())"
    Description = "Client scaffold imported from clients/_template/$($_.Name)"
    SourcePath = $_.FullName
    RelativePath = "clients/_template/$($_.Name)"
    Tags = @("template", "client")
  }
}

$workspaceReadme = Read-SourceFile -Path (Join-Path $workspaceRoot "README.md")
$workspaceAgents = Read-SourceFile -Path (Join-Path $workspaceRoot "AGENTS.md")
$orgStructure = Read-SourceFile -Path (Join-Path $workspaceRoot "agency\org-structure.md")
$agentRoles = Read-SourceFile -Path (Join-Path $workspaceRoot "agency\agent-roles.md")

$companyBody = @"
# Lubit Growth Studio

Pacote de importacao reconstruido a partir do workspace atual em workspace/lubit-growth-studio/.

## O que este pacote recria

- empresa base da agencia
- agentes oficiais
- skills derivadas de workflows, templates e guias operacionais
- projetos derivados dos clientes reais presentes em clients/

## README do workspace original

$($workspaceReadme.Trim())

## AGENTS.md do workspace original

$($workspaceAgents.Trim())

## Estrutura organizacional

$($orgStructure.Trim())

## Matriz de papeis

$($agentRoles.Trim())
"@

$companyFrontmatter = @(
  "schema: agentcompanies/v1",
  "name: Lubit Growth Studio",
  "slug: lubit-growth-studio",
  "description: Agencia de marketing digital operada com Paperclip e Codex.",
  "goals:",
  "  - Operar a agencia com clareza, consistencia e rastreabilidade.",
  "  - Reaproveitar workflows, templates e papeis sem reinventar processo.",
  "  - Transformar clientes presentes em clients/ em projetos ativos dentro do Paperclip."
)

Write-Utf8File -Path (Join-Path $outputRoot "COMPANY.md") -Content (New-MarkdownDocument -FrontmatterLines $companyFrontmatter -Body $companyBody)

$paperclipConfigLines = @(
  "schema: paperclip/v1",
  "agents:"
)

$agentFiles = @(Get-ChildItem -LiteralPath (Join-Path $workspaceRoot "agents") -Filter "*.md" | Sort-Object Name)

foreach ($agentFile in $agentFiles) {
  $slug = $agentFile.BaseName.ToLowerInvariant()
  $meta = $agentMetadata[$slug]
  if (-not $meta) {
    throw "Missing metadata for agent '$slug'"
  }

  $agentFrontmatter = @(
    "name: $($meta.Name)",
    "slug: $slug",
    "title: $($meta.Title)"
  )

  if ($meta.Role) {
    $agentFrontmatter += "role: $($meta.Role)"
  }

  if ($null -eq $meta.ReportsTo) {
    $agentFrontmatter += "reportsTo: null"
  } else {
    $agentFrontmatter += "reportsTo: $($meta.ReportsTo)"
  }

  $agentFrontmatter += "skills:"
  foreach ($skill in $meta.Skills) {
    $agentFrontmatter += "  - $skill"
  }

  $agentSourceContent = (Read-SourceFile -Path $agentFile.FullName).Trim()

  $agentBody = @"
$agentSourceContent

## Arquivo de origem

- agents/$($agentFile.Name)
"@

  $agentPath = Join-Path $outputRoot "agents\$slug\AGENTS.md"
  Write-Utf8File -Path $agentPath -Content (New-MarkdownDocument -FrontmatterLines $agentFrontmatter -Body $agentBody)

  $paperclipConfigLines += "  ${slug}:"
  $paperclipConfigLines += "    adapter:"
  $paperclipConfigLines += "      type: codex_local"
  $paperclipConfigLines += "      config:"
  $paperclipConfigLines += "        cwd: /workspace/lubit-growth-studio"
  $paperclipConfigLines += "        instructionsFilePath: /workspace/lubit-growth-studio/agents/$slug.md"
  $paperclipConfigLines += "        timeoutSec: 1800"
  $paperclipConfigLines += "        graceSec: 15"
}

Write-Utf8File -Path (Join-Path $outputRoot ".paperclip.yaml") -Content ($paperclipConfigLines -join [Environment]::NewLine)

foreach ($skill in $skillSources) {
  $tagLines = @()
  if ($skill.Tags.Count -gt 0) {
    $tagLines += "tags:"
    foreach ($tag in $skill.Tags) {
      $tagLines += "  - $tag"
    }
  }

  $skillFrontmatter = @(
    "name: $($skill.Name)",
    "slug: $($skill.Slug)",
    "description: $($skill.Description)"
  ) + $tagLines

  $skillSourceContent = (Read-SourceFile -Path $skill.SourcePath).Trim()

  $skillBody = @"
Arquivo de origem: $($skill.RelativePath)

$skillSourceContent
"@

  $skillPath = Join-Path $outputRoot "skills\$($skill.Slug)\SKILL.md"
  Write-Utf8File -Path $skillPath -Content (New-MarkdownDocument -FrontmatterLines $skillFrontmatter -Body $skillBody)
}

$clientDirectories = Get-ChildItem -LiteralPath (Join-Path $workspaceRoot "clients") -Directory | Where-Object { $_.Name -ne "_template" } | Sort-Object Name

foreach ($clientDirectory in $clientDirectories) {
  $projectSlug = $clientDirectory.Name.ToLowerInvariant()
  $projectName = Get-TitleCaseName -Slug ($projectSlug -replace "-", " ")
  $projectPath = Join-Path $outputRoot "projects\$projectSlug"
  $referencesPath = Join-Path $projectPath "references"
  $tasksPath = Join-Path $projectPath "tasks"

  Ensure-Directory -Path $referencesPath
  Ensure-Directory -Path $tasksPath

  $clientFiles = Get-ChildItem -LiteralPath $clientDirectory.FullName -Recurse -File -Filter "*.md" | Sort-Object FullName
  $relativeClientFiles = @()
  foreach ($clientFile in $clientFiles) {
    $relativePath = $clientFile.FullName.Substring($clientDirectory.FullName.Length + 1).Replace("\", "/")
    $relativeClientFiles += $relativePath
    $targetReference = Join-Path $referencesPath $relativePath
    Ensure-Directory -Path (Split-Path -Parent $targetReference)
    Copy-Item -LiteralPath $clientFile.FullName -Destination $targetReference -Force
  }

  $briefPath = Join-Path $clientDirectory.FullName "brief.md"
  $initialPlanPath = Join-Path $clientDirectory.FullName "reports\ceo-initial-plan.md"

  $projectSections = @(
    "# Projeto importado: $projectName",
    "",
    "Origem: clients/$($clientDirectory.Name)/",
    "",
    "## Arquivos preservados",
    "",
    (Format-Bullets -Items $relativeClientFiles)
  )

  if (Test-Path $briefPath) {
    $projectSections += ""
    $projectSections += "## Brief atual"
    $projectSections += ""
    $projectSections += (Read-SourceFile -Path $briefPath).Trim()
  }

  if (Test-Path $initialPlanPath) {
    $projectSections += ""
    $projectSections += "## Plano inicial existente"
    $projectSections += ""
    $projectSections += (Read-SourceFile -Path $initialPlanPath).Trim()
  }

  $projectFrontmatter = @(
    "name: $projectName",
    "slug: $projectSlug",
    "description: Cliente importado da estrutura atual da Lubit Growth Studio.",
    "owner: strategy-director"
  )

  Write-Utf8File -Path (Join-Path $projectPath "PROJECT.md") -Content (New-MarkdownDocument -FrontmatterLines $projectFrontmatter -Body ($projectSections -join [Environment]::NewLine))

  if (Test-Path $briefPath) {
    $briefTaskFrontmatter = @(
      "name: Validar brief de $projectName",
      "slug: validar-brief",
      "assignee: market-researcher",
      "project: $projectSlug"
    )
    $briefTaskBody = @"
Revisar o brief preservado em projects/$projectSlug/references/brief.md, separar fatos confirmados de hipoteses e sinalizar lacunas que impactam estrategia, copy e midia.
"@
    Write-Utf8File -Path (Join-Path $tasksPath "validar-brief\TASK.md") -Content (New-MarkdownDocument -FrontmatterLines $briefTaskFrontmatter -Body $briefTaskBody)
  }

  if (Test-Path $initialPlanPath) {
    $planTaskFrontmatter = @(
      "name: Transformar plano inicial em execucao para $projectName",
      "slug: operacionalizar-plano-inicial",
      "assignee: strategy-director",
      "project: $projectSlug"
    )
    $planTaskBody = @"
Usar projects/$projectSlug/references/reports/ceo-initial-plan.md como base para abrir a sequencia inicial de estrategia, copy, midia, medicao e QA dentro do projeto.
"@
    Write-Utf8File -Path (Join-Path $tasksPath "operacionalizar-plano-inicial\TASK.md") -Content (New-MarkdownDocument -FrontmatterLines $planTaskFrontmatter -Body $planTaskBody)
  }

  $qaTaskFrontmatter = @(
    "name: Preparar QA inicial de $projectName",
    "slug: preparar-qa-inicial",
    "assignee: qa-editor",
    "project: $projectSlug"
  )
  $qaTaskBody = @"
Depois que a estrategia inicial e os materiais prioritarios forem consolidados, revisar clareza, claims, CTA e aderencia ao brief antes de liberar a primeira entrega.
"@
  Write-Utf8File -Path (Join-Path $tasksPath "preparar-qa-inicial\TASK.md") -Content (New-MarkdownDocument -FrontmatterLines $qaTaskFrontmatter -Body $qaTaskBody)
}

Write-Host "Import package rebuilt at: $outputRoot"
