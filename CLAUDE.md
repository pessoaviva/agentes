# Equipe de Agentes de IA — Criação de Sites e Sistemas

Este repositório é um **plugin do Claude Code** com uma equipe de agentes
especializados para construir sites e sistemas (simples ou complexos) de ponta a
ponta, com a inteligência do modelo que você estiver usando (Opus 4.8 / Fable 5).

## Os agentes

| Agente | Papel | Quando entra |
|---|---|---|
| **criador-de-sites** | Escreve todo o código-fonte (back-end, banco, APIs, lógica) | Fase 1 — construção |
| **designer** | Cria todo o front-end e o design (nível "Claude design") | Fase 1 — em paralelo |
| **testador** | Testa tudo na pele do cliente e reporta o que não funciona | Fase 2 — teste de aceitação |
| **ciberseguranca** | Cria login e blinda a segurança (OWASP) | Fase 3 — depois do sistema pronto |
| **hacker** | Pentester ético: acha as falhas e reporta | Fase 4 — por último |
| **corretor-de-bugs** | Vistoria o código e conserta bugs (construção + pós-lançamento) | Fases 1–6 — sob demanda |
| **/gerente** (comando) | Orquestra tudo em pipeline simultâneo, como uma rede neural | Sempre que quiser conduzir o fluxo completo |

> **Rede neural de pensamento:** a IA principal (Fable 5 / Opus 4.8) é o "córtex/hub" e
> os agentes são neurônios especializados. Como subagentes não conversam entre si, eles
> se conectam **através da IA principal** + um **arquivo de estado compartilhado**
> (`docs/ESTADO.md`) que o gerente mantém. Todo prompt de agente começa com "leia
> `docs/ESTADO.md`" e termina devolvendo um relatório no formato padrão (suposições,
> confiança, arquivos tocados, o que precisa dos outros); a IA principal sintetiza,
> atualiza o `ESTADO.md` e converge para uma conclusão só.

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
    ├── agents/        # criador-de-sites, designer, testador, ciberseguranca, hacker, corretor-de-bugs
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

Cada fase tem um **portão** (o "pronto") — o gerente não avança sem ele.

```
Fase 0  Levantamento de requisitos → escreve docs/ESTADO.md
        🚪 portão: resumo confirmado pelo usuário + ESTADO.md criado
           │
           ▼
Fase 1  criador-de-sites  +  designer   (pipeline por peça, SEM editar o mesmo arquivo)
        + corretor-de-bugs vistoria em paralelo
        🚪 portão: app sobe + smoke test passa
           │
           ▼
Fase 2  testador SOBE o app e navega com Playwright (na pele do cliente)
        → conserta em lote → testador RE-TESTA a correção
        🚪 portão: veredito "aprovado", sem Bloqueante nem Alto
           │
           ▼
Fase 3  ciberseguranca  (cria login de ponta a ponta + blinda OWASP)
        → testador valida o fluxo de login REAL (que era stub na Fase 2)
        🚪 portão: auth real + blindagem + build passa + login validado
           │
           ▼
Fase 4  hacker SOBE o app e ataca → ciberseguranca corrige em lote → hacker de novo
        (TETO de 3 rodadas; se sobrar Crítica/Alta, escala ao usuário)
        🚪 portão: relatório do hacker limpo (ou teto atingido + decisão do usuário)
           │
           ▼
Fase 5  🚀 Deploy (dono: criador-de-sites) — build, .env.example, hospedagem, CI
        🚪 portão: build de produção passa + lista do que o cliente precisa configurar
           │
           ▼
Fase 6  🐛 App no ar (fase contínua) → corretor-de-bugs conserta bugs pós-lançamento
        (reproduz → causa-raiz → menor correção segura) → testador valida
```

## Estrutura do repositório (layout de plugin)

```
agentes/
├── .claude/                 # cópia p/ a Forma 3 (projeto/nuvem) — gerada por sincronizar.sh
│   ├── agents/
│   └── commands/
├── .claude-plugin/
│   ├── plugin.json          # manifesto do plugin
│   └── marketplace.json     # marketplace que publica este plugin
├── agents/                  # os 6 agentes trabalhadores (FONTE CANÔNICA — edite aqui)
│   ├── criador-de-sites.md
│   ├── designer.md
│   ├── testador.md
│   ├── ciberseguranca.md
│   ├── hacker.md
│   └── corretor-de-bugs.md
├── commands/
│   └── gerente.md           # o orquestrador (vira /agentes:gerente)
├── instalar-agentes.sh      # instalação alternativa em ~/.claude
└── sincronizar.sh           # replica agents/ e commands/ para .claude/
```

### Manutenção (ao alterar qualquer agente ou o gerente)

1. Edite SEMPRE em `agents/` e `commands/` — são a fonte canônica.
2. Rode `bash sincronizar.sh` para replicar em `.claude/` (senão a Forma 3 fica defasada
   e as duas cópias divergem).
3. Suba a `version` em `.claude-plugin/plugin.json` **e** `marketplace.json` — sem isso,
   `/plugin marketplace update pessoaviva` não enxerga a mudança.

## Observação sobre o modelo (Fable 5 é o premium)

**Fable 5 é o modelo mais capaz** — é o cérebro que faz o trabalho generativo e crítico.
Os agentes que **criam/consertam o produto** vêm fixos em `model: fable`:
**criador-de-sites, designer, ciberseguranca e corretor-de-bugs**. Eles rodam com a
inteligência do Fable 5 **mesmo que a sua sessão esteja em Sonnet 5** (ou outro modelo).

Os agentes que só **leem e reportam** (**testador** e **hacker**) vêm em `model: sonnet`
— dá conta da leitura/varredura e é mais barato. Não é rebaixamento: é usar o motor certo
para o papel certo (economia real).

- **Fallback automático e seguro:** se o modelo fixado não estiver disponível na sua
  sessão, o Claude Code usa o modelo da sessão em vez de dar erro (o "mais próximo possível").
- **O comando `/gerente` (o hub) roda no modelo da sessão** — ele é injetado na IA
  principal e não dá para fixar o modelo dele. Então: abra a sessão em Fable 5 para ter
  Fable 5 também na orquestração.
- **Custo:** o Fable 5 consome o limite de uso mais rápido. Se preferir que os agentes
  sigam o modelo da sessão, troque o `model:` por `inherit` nos arquivos de `agents/`.

### Roteador automático (por papel, não por "força")

O `/gerente` roteia o **modelo por papel** e o **esforço pela dificuldade** — o que
economiza de verdade, sem inverter a hierarquia dos modelos:

- **Trivial** (texto, 1 linha, dúvida): a IA principal faz **inline**, sem gastar subagente.
- **Leitura/varredura** (testador, hacker no recon): **Sonnet 5**.
- **Construção/conserto** (criador, designer, ciberseguranca, corretor): **Fable 5**.
- **Crítico** (segurança, dinheiro, dados, bug cabeludo): **Fable 5** com **esforço máximo**.
- **Ultracode:** Fable 5 + passada de **auto-revisão** (skill `code-review`) antes de entregar.
- **Opus 4.8:** alternativa premium **lado a lado** do Fable (um segundo cérebro), **não**
  um degrau acima dele.

O modelo troca de verdade em cada chamada de agente (parâmetro `model` no Task); o esforço
(`low`→`max`) é ajuste de sessão. Detalhes na tabela dentro do `commands/gerente.md`.
