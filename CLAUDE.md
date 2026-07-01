# Equipe de Agentes de IA — Criação de Sites e Sistemas

Este repositório é um **plugin do Claude Code** com uma equipe de agentes
especializados para construir sites e sistemas (simples ou complexos) de ponta a
ponta, com a inteligência do modelo que você estiver usando (Opus 4.8 / Fable 5).

## Os agentes

| Agente | Papel | Quando entra |
|---|---|---|
| **criador-de-sites** | Escreve todo o código-fonte (back-end, banco, APIs, lógica) | Fase 1 — construção |
| **designer** | Cria todo o front-end e o design (nível "Claude design") | Fase 1 — em paralelo |
| **ciberseguranca** | Cria login e blinda a segurança (OWASP) | Fase 3 — depois do sistema pronto |
| **hacker** | Pentester ético: acha as falhas e reporta | Fase 4 — por último |
| **/gerente** (comando) | Orquestra tudo na ordem certa | Sempre que quiser conduzir o fluxo completo |

> **Por que o "gerente" é um comando e não um agente?** No Claude Code, um subagente
> roda isolado e não consegue dar ordens à IA principal nem chamar outros subagentes —
> quem orquestra é sempre a IA principal. Por isso o Gerente é um comando: ele injeta
> todo o passo-a-passo na IA principal e a coloca no comando da orquestração.

## Como usar em QUALQUER projeto — 2 formas

### Forma 1 (recomendada): instalar como plugin
Instala uma vez, vale em todos os projetos e atualiza fácil via `git`. Dentro do
Claude Code:

```
/plugin marketplace add pessoaviva/agentes
/plugin install agentes@pessoaviva
```

Depois, em qualquer projeto:
- Comando: `/agentes:gerente` (fluxo completo)
- Agentes: "use o agente criador-de-sites para...", etc. (aparecem em `/agents`)
- Atualizar quando você mudar algo aqui: `/plugin marketplace update pessoaviva`

### Forma 2: instalar no nível do usuário (sem plugin)
Copia os arquivos para `~/.claude/`. O comando fica `/gerente` (sem prefixo).

```bash
bash instalar-agentes.sh
```

## O fluxo de trabalho (o que o gerente conduz)

```
Fase 1  criador-de-sites  +  designer   (em paralelo: lógica + visual)
           │
           ▼
Fase 2  ✅ Sistema pronto  →  checkpoint com o usuário
           │
           ▼
Fase 3  ciberseguranca     (cria login + blinda segurança)
           │
           ▼
Fase 4  hacker  →  acha falhas  →  ciberseguranca corrige  →  hacker testa de novo
        (repete até não sobrar falha crítica/alta)
```

## Estrutura do repositório (layout de plugin)

```
agentes/
├── .claude-plugin/
│   ├── plugin.json          # manifesto do plugin
│   └── marketplace.json     # marketplace que publica este plugin
├── agents/                  # os 4 agentes trabalhadores
│   ├── criador-de-sites.md
│   ├── designer.md
│   ├── ciberseguranca.md
│   └── hacker.md
├── commands/
│   └── gerente.md           # o orquestrador (vira /agentes:gerente)
└── instalar-agentes.sh      # instalação alternativa em ~/.claude
```

## Observação sobre o modelo

Os agentes usam `model: inherit` — ou seja, rodam com **o mesmo modelo da sua sessão
principal**. Se você abrir o Claude Code com Fable 5 (ou Opus 4.8), os agentes herdam
essa inteligência automaticamente.
