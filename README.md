# agentes

Plugin do **Claude Code** com uma equipe de **9 agentes de IA + 2 comandos**
para criar e manter sites e sistemas (simples ou complexos) de ponta a ponta, com a
inteligência do modelo que você usar (Fable 5 / Opus 4.8).

## A equipe (9 agentes + os comandos /gerente e /retomar)

1. **criador-de-sites** — escreve todo o código-fonte (lógica, back-end, banco, APIs).
2. **designer** — cria todo o front-end e o design (nível "Claude design").
3. **testador** — testa tudo na pele do cliente e reporta o que não funciona.
4. **ciberseguranca** — cria o login e blinda a segurança do sistema (OWASP).
5. **hacker** — pentester ético: tenta quebrar o sistema pronto e reporta as falhas.
6. **corretor-de-bugs** — vistoria o código e conserta bugs (construção e pós-lançamento).
7. **revisor-de-codigo** — segundo olhar independente no código crítico (aponta, não conserta).
8. **otimizador** — SEO técnico + performance (Core Web Vitals), sem mudar visual nem lógica.
9. **documentador** — manual do cliente, guia de administração e README de entrega.

E dois comandos: **/gerente**, que orquestra tudo em pipeline simultâneo (é comando, e
não agente, porque quem orquestra é sempre a IA principal), e **/retomar**, que mostra
onde o projeto parou lendo o `docs/ESTADO.md` (o nome evita colisão com o `/status`
nativo do Claude Code). Instale por **uma** via só — plugin OU cópia local — para não
duplicar os agentes.

## Instalar e usar em QUALQUER projeto

### Recomendado: como plugin (instala uma vez, vale em tudo)

Dentro do Claude Code, rode:

```
/plugin marketplace add pessoaviva/agentes
/plugin install agentes@pessoaviva
```

Depois, em qualquer projeto:

- `/agentes:gerente` → conduz o fluxo completo.
- ou acione um agente direto: *"use o agente criador-de-sites para..."*.
- para atualizar depois de mudar algo aqui: `/plugin marketplace update pessoaviva`.

### Alternativa: instalar em `~/.claude` (comando fica `/gerente`)

```bash
bash instalar-agentes.sh
```

## Fluxo de trabalho

O gerente conduz por fases, cada uma com um **portão** (o "pronto"), e mantém um estado
compartilhado em `docs/ESTADO.md` (todo agente lê esse arquivo e devolve relatório padrão):

```
requisitos → criador-de-sites + designer → testador → ciberseguranca → hacker → 🚀 deploy → 🐛 manutenção
 (ESTADO.md)  (pipeline por peça,          (sobe o app  (login+          (ataca o    (build +     (pós-lança-
              sem editar o mesmo arquivo)   e navega)    blindagem)       app pronto)  hospedagem)  mento)
```

- **testador** e **hacker** sobem o app de verdade e navegam com Playwright (não só leem o código).
- Laço **hacker ↔ ciberseguranca** tem teto de **3 rodadas**; correções são validadas por quem
  não as fez (o **testador** re-testa).

Detalhes completos em [`CLAUDE.md`](./CLAUDE.md).
