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
| **corretor-de-bugs** | Conserta bugs pós-lançamento (manutenção/incidentes) | Fase 5 — app já no ar |
| **/gerente** (comando) | Orquestra tudo como uma rede neural, na ordem certa | Sempre que quiser conduzir o fluxo completo |

> **Rede neural de pensamento:** a IA principal (Opus 4.8 / Fable 5) é o "córtex/hub" e
> os agentes são neurônios especializados. Como subagentes não conversam entre si, eles
> se conectam **através da IA principal** + um contexto compartilhado (o "resumo do
> projeto"). Cada agente declara suas suposições, sua confiança e o que precisa dos
> outros; a IA principal sintetiza e converge para uma conclusão só.

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

### Forma 3: dentro do projeto (funciona na nuvem / Claude Code na web / desktop)
O comando `/plugin` **só existe no Claude Code local (do seu PC)**. No Claude Code na
nuvem (web/desktop remoto) ele não está disponível. Para usar os agentes lá, coloque
a pasta `.claude/` **dentro do projeto** — é o que este repositório já traz pronto:

```
seu-projeto/
└── .claude/
    ├── agents/        # criador-de-sites, designer, ciberseguranca, hacker, corretor-de-bugs
    └── commands/
        └── gerente.md # vira /gerente (sem prefixo, pois não é plugin)
```

Basta copiar a pasta `.claude/` deste repositório para dentro do projeto do cliente,
commitar, e abrir uma sessão nova. Os agentes carregam automaticamente e rodam igual
(o Claude principal aciona cada subagente de verdade). Atalho: em uma sessão na nuvem,
peça *"copie os agentes de github.com/pessoaviva/agentes para a pasta .claude deste
projeto"*.

> Os agentes são lidos **no início da sessão**. Se acabou de adicionar a pasta
> `.claude/`, abra uma sessão nova no projeto para eles aparecerem.

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
           │
           ▼
Fase 5  🐛 App no ar  →  corretor-de-bugs conserta bugs pós-lançamento
        (reproduz → causa-raiz → menor correção segura → testa regressão)
```

## Estrutura do repositório (layout de plugin)

```
agentes/
├── .claude-plugin/
│   ├── plugin.json          # manifesto do plugin
│   └── marketplace.json     # marketplace que publica este plugin
├── agents/                  # os 5 agentes trabalhadores
│   ├── criador-de-sites.md
│   ├── designer.md
│   ├── ciberseguranca.md
│   ├── hacker.md
│   └── corretor-de-bugs.md
├── commands/
│   └── gerente.md           # o orquestrador (vira /agentes:gerente)
└── instalar-agentes.sh      # instalação alternativa em ~/.claude
```

## Observação sobre o modelo (Fable 5 fixo)

Os 5 agentes trabalhadores usam `model: fable` — ou seja, rodam com a inteligência do
**Fable 5 mesmo que a sua sessão esteja em Sonnet 5** (ou outro modelo). Assim você
sempre tem o melhor cérebro nos agentes, sem depender do modelo que abriu.

- **Fallback automático e seguro:** se o Fable 5 não estiver disponível na sua sessão,
  o Claude Code usa o modelo da sessão em vez de dar erro (o "mais próximo possível").
- **O comando `/gerente` (o hub) roda no modelo da sessão** — ele é injetado na IA
  principal e não dá para fixar o modelo dele. Então: abra a sessão em Fable 5 para ter
  Fable 5 também na orquestração; os 5 agentes já vêm fixos em Fable 5 de qualquer forma.
- **Custo:** o Fable 5 consome o limite de uso mais rápido. Se preferir que os agentes
  sigam o modelo da sessão, troque `model: fable` por `model: inherit` nos arquivos de
  `agents/`.
