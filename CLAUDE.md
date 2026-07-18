# Equipe de Agentes de IA — Criação de Sites e Sistemas

Este repositório é um **plugin do Claude Code** com uma equipe de agentes
especializados para construir sites e sistemas (simples ou complexos) de ponta a
ponta, com a inteligência do modelo que você estiver usando (Opus 4.8 / Sonnet 5).

## Os agentes

| Agente | Papel | Quando entra |
|---|---|---|
| **criador-de-sites** | Escreve todo o código-fonte (back-end, banco, APIs, lógica) | Fase 1 — construção |
| **designer** | Cria todo o front-end e o design (nível "Claude design") | Fase 1 — em paralelo |
| **testador** | Testa tudo na pele do cliente e reporta o que não funciona | Fase 2 — teste de aceitação |
| **ciberseguranca** | Cria login e blinda a segurança (OWASP) | Fase 3 — depois do sistema pronto |
| **hacker** | Pentester ético: acha as falhas e reporta | Fase 4 — por último |
| **corretor-de-bugs** | Vistoria o código e conserta bugs (construção + pós-lançamento) | Fases 1–6 — sob demanda |
| **revisor-de-codigo** | Segundo olhar independente no código crítico (aponta, não conserta) | Fases 1–6 — sob demanda |
| **otimizador** | SEO técnico + performance (Core Web Vitals), sem mudar visual/lógica | Fase 5 — antes do build final |
| **documentador** | Manual do cliente, guia de administração e README de entrega | Fase 5 — junto do deploy |
| **/gerente** (comando) | Orquestra tudo em pipeline simultâneo, como uma rede neural | Sempre que quiser conduzir o fluxo completo |
| **/retomar** (comando) | Mostra onde o projeto parou (fase, peças, pendências), lendo o ESTADO.md | Qualquer momento — retomar sessão |

> **Rede neural de pensamento:** a IA principal (Opus 4.8 / Sonnet 5) é o "córtex/hub" e
> os agentes são neurônios especializados. Como subagentes não conversam entre si, eles
> se conectam **através da IA principal** + um **arquivo de estado compartilhado**
> (`docs/ESTADO.md`) que o gerente mantém. Todo prompt de agente começa com "leia
> `docs/ESTADO.md`" e termina devolvendo um relatório no formato padrão (suposições,
> confiança, arquivos tocados, o que precisa dos outros); a IA principal sintetiza,
> atualiza o `ESTADO.md` e converge para uma conclusão só. Cada agente ainda mantém sua
> **memória de erros** em `docs/licoes/<agente>.md` — lições de 1 linha que ele relê a
> cada chamada e alimenta quando erra: errou uma vez, não erra de novo.

> **Por que o "gerente" é um comando e não um agente?** No Claude Code, um subagente
> roda isolado e não consegue dar ordens à IA principal nem chamar outros subagentes —
> quem orquestra é sempre a IA principal. Por isso o Gerente é um comando: ele injeta
> todo o passo-a-passo na IA principal e a coloca no comando da orquestração.

## Como usar em QUALQUER projeto — 3 formas

> ⚠️ **Use UMA forma por projeto.** Plugin instalado + pasta `.claude/` no projeto (ou +
> cópia em `~/.claude`) = agentes duplicados, com versões que divergem sem ninguém notar.

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
    ├── agents/        # os 9 agentes da equipe (criador-de-sites, designer, testador, ...)
    └── commands/
        ├── gerente.md # vira /gerente (sem prefixo, pois não é plugin)
        └── retomar.md # vira /retomar (nome que não colide com o /status nativo)
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

> ⚡ **Antes de tudo, o gerente tria a complexidade.** Site simples (landing page,
> estático, sem login/banco) vai pelo **Modo Rápido**: construção inline ou 1 passada de
> designer em Sonnet 5, **pulando as fases de segurança e o QA formal**. O fluxo completo
> abaixo (Modo Completo) é para **sistemas** de verdade — não desperdice ele numa landing.

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
        + otimizador (SEO/performance) + documentador (manual do cliente) em paralelo
        🚪 portão: build passa + auditoria sem item grave + manual entregue + lista do cliente
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
├── agents/                  # os 9 agentes trabalhadores (FONTE CANÔNICA — edite aqui)
│   ├── criador-de-sites.md · designer.md · testador.md
│   ├── ciberseguranca.md · hacker.md · corretor-de-bugs.md
│   └── revisor-de-codigo.md · otimizador.md · documentador.md
├── commands/
│   ├── gerente.md           # o orquestrador (vira /agentes:gerente)
│   └── retomar.md           # /retomar — onde o projeto parou (lê o ESTADO.md)
├── instalar-agentes.sh      # instalação alternativa em ~/.claude
└── sincronizar.sh           # replica agents/ e commands/ para .claude/
```

### Manutenção (ao alterar qualquer agente ou o gerente)

1. Edite SEMPRE em `agents/` e `commands/` — são a fonte canônica.
2. Rode `bash sincronizar.sh` para replicar em `.claude/` (senão a Forma 3 fica defasada
   e as duas cópias divergem).
3. Suba a `version` em `.claude-plugin/plugin.json` **e** `marketplace.json` — sem isso,
   `/plugin marketplace update pessoaviva` não enxerga a mudança.

## Observação sobre o modelo (Opus 4.8 é o premium)

**Opus 4.8 é o modelo mais capaz** — é o cérebro que faz o trabalho generativo e crítico.
Os agentes que **criam/consertam o produto** vêm fixos em `model: opus`:
**criador-de-sites, designer, ciberseguranca, corretor-de-bugs e otimizador**. Eles rodam
com a inteligência do Opus 4.8 **mesmo que a sua sessão esteja em Sonnet 5** (ou outro modelo).

Os agentes que só **leem e reportam/explicam** (**testador**, **hacker**,
**revisor-de-codigo** e **documentador**) vêm em `model: sonnet` — dá conta da
leitura/varredura/redação e é mais barato. Não é rebaixamento: é usar o motor certo
para o papel certo (economia real).

- **Fallback automático confirmado (docs oficiais):** `opus` é alias válido de `model`
  no frontmatter, e um valor indisponível/fora do allowlist da organização é ignorado —
  o subagente roda no modelo da sessão em vez de dar erro. (Só num CLI muito antigo,
  anterior ao alias, troque `model: opus` por `inherit` — 1 min — e siga.)
- **O comando `/gerente` (o hub) roda no modelo da sessão** — ele é injetado na IA
  principal e não dá para fixar o modelo dele. Então: abra a sessão em Opus 4.8 para ter
  Opus 4.8 também na orquestração (ou em Sonnet 5, no modo econômico).
- **Custo:** o Opus 4.8 é o mais caro e consome o limite mais rápido — por isso o roteador
  manda **construção simples (landing page, página estática) para Sonnet 5** e só reserva
  o Opus para lógica/arquitetura de verdade. Se preferir que os agentes sigam o modelo da
  sessão, troque o `model:` por `inherit` nos arquivos de `agents/`.

### Roteador automático (por papel e por dificuldade)

O `/gerente` roteia o **modelo por papel** e o **esforço pela dificuldade**:

- **Trivial** (texto, 1 linha, dúvida): a IA principal faz **inline**, sem gastar subagente.
- **Mecânico** (rodar build/teste e dizer se passou, conversão, conferência): **Haiku 4.5** (~80% mais barato).
- **Leitura/varredura** (testador, hacker no recon, revisor-de-codigo, documentador): **Sonnet 5**.
- **Construção simples** (landing page, página estática, texto, ajuste visual sem lógica): **Sonnet 5**.
- **Construção/conserto com lógica** (criador, designer, ciberseguranca, corretor, otimizador): **Opus 4.8**.
- **Crítico** (segurança, dinheiro, dados, bug cabeludo): **Opus 4.8** com **esforço máximo**.
- **Ultracode:** Opus 4.8 + passada de **auto-revisão** (skill `code-review`) antes de entregar.

O modelo troca de verdade em cada chamada de agente (parâmetro `model` no Task); o esforço
(`low`→`max`) é ajuste de sessão. Detalhes na tabela dentro do `commands/gerente.md`.

## 💸 Economia de tokens (o custo é MULTIPLICATIVO)

O modelo relê o histórico inteiro a cada turno — cada linha no contexto é paga de novo em
todos os turnos seguintes. O time já foi desenhado para isso: trabalho pesado acontece
**dentro** dos subagentes (na janela principal só entram briefing e relatório), relatórios
têm **teto de ~25 linhas** com `arquivo:linha` em vez de código colado, e o `ESTADO.md` é
memória externa enxuta. Do seu lado (o usuário):

- **⚡ Case a complexidade do projeto ao esforço — o maior gasto é overkill.** Uma landing
  page NÃO deve custar 100k+ de tokens: se custou, o pipeline pesado (9 agentes, Playwright,
  fases de segurança) rodou num projeto que pedia o **Modo Rápido** (o gerente triа isso na
  Fase 0). Site simples/estático sem login nem banco → construção inline ou 1 passada de
  designer em **Sonnet 5**, sem as fases de segurança e sem QA formal. Diga ao gerente
  *"é uma landing page simples, faz no modo rápido"* se ele não triar sozinho.
- **`/clear` nos portões de fase** — o gerente avisa quando é seguro: o `ESTADO.md` guarda
  tudo e o `/retomar` re-hidrata em segundos. Maior ganho em projeto longo: janela sempre
  pequena em vez de arrastar 100k+ de histórico.
- **`/compact` cedo** (~50% do contexto; veja em `/context`) — não espere o aviso dos 95%.
  Acompanhe o gasto com `/usage`.
- **Agrupe pedidos** num prompt só; se errar, **edite a mensagem** em vez de mandar
  correção (senão erro + correção ficam no histórico para sempre).
- **Desconecte MCPs que não vai usar** (`/mcp`) — servidor conectado pode custar milhares
  de tokens por mensagem mesmo parado.
- **Cache de prompt paga ~10% na releitura do que não mudou** — mantenha o prefixo
  estável: não troque CLAUDE.md/memória nem conecte/desconecte MCP no meio da sessão
  (invalida o cache dali em diante). Pausas longas esfriam o cache (~5 min no padrão) —
  trabalhe em blocos contínuos.
- **Contexto blindado no projeto do cliente:** o gerente cria `.claude/settings.json`
  com deny de leitura (node_modules, dist, locks, .env) — contexto inicial até ~90%
  menor e ninguém lê segredo por engano. (Não existe `.claudeignore` nativo; o
  equivalente oficial são as regras `permissions.deny` — foi o que usamos.)
- **Modo econômico:** sessão em **Sonnet 5** — os agentes de construção pesada continuam
  fixos em **Opus 4.8** (só entram quando há lógica de verdade), a construção simples e a
  leitura ficam em **Sonnet** e o mecânico vai para **Haiku**. E o CLAUDE.md do projeto do
  cliente deve ficar enxuto (< 200 linhas): ele entra em TODA mensagem.
- **Opcional (ferramenta externa):** [RTK](https://github.com/rtk-ai/rtk) comprime output
  de comandos (git/testes/grep) em 60–90% antes de entrar no contexto (`rtk init --global`).
