# Equipe de Agentes de IA — Criação de Sites e Sistemas

Este repositório contém uma equipe de **agentes especializados** para o Claude Code,
pensada para construir sites e sistemas (simples ou complexos) de ponta a ponta, com
a inteligência do modelo que você estiver usando (Opus 4.8 / Fable 5).

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
> quem orquestra é sempre a IA principal. Por isso o Gerente é o comando `/gerente`:
> ele injeta todo o passo-a-passo na IA principal e a coloca no comando da orquestração.

## Como usar

1. **Fluxo completo automatizado:** digite `/gerente` e diga o que quer construir. A
   IA vai conduzir as 4 fases (construção + design em paralelo → checkpoint →
   segurança → pentest).
2. **Acionar um agente específico:** peça em linguagem natural, ex.:
   - "Use o agente criador-de-sites para montar um sistema de agendamento."
   - "Chama o designer para deixar essa tela profissional."
   - "Aciona o ciberseguranca para blindar o login."
   - "Manda o hacker procurar falhas nesse sistema."

## O fluxo de trabalho (resumo)

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

## Rodar em QUALQUER pasta (instalação global)

Por padrão, esses agentes valem só neste projeto (ficam em `.claude/`). Para usá-los
em **todas as suas pastas**, instale-os no nível do usuário (`~/.claude/`):

```bash
bash instalar-agentes.sh
```

Isso copia os agentes para `~/.claude/agents/` e o comando `/gerente` para
`~/.claude/commands/`. Depois disso, eles funcionam em qualquer diretório em que você
abrir o Claude Code, sem precisar copiar nada.

## Observação sobre o modelo

Os agentes usam `model: inherit` — ou seja, rodam com **o mesmo modelo da sua sessão
principal**. Se você abrir o Claude Code com Fable 5 (ou Opus 4.8), os agentes herdam
essa inteligência automaticamente.
