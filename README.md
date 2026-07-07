# agentes

Plugin do **Claude Code** com uma equipe de **7 agentes de IA** para criar e manter
sites e sistemas (simples ou complexos) de ponta a ponta, com a inteligência do modelo
que você usar (Opus 4.8 / Fable 5).

## Os 7 agentes

1. **criador-de-sites** — escreve todo o código-fonte (lógica, back-end, banco, APIs).
2. **designer** — cria todo o front-end e o design (nível "Claude design").
3. **testador** — testa tudo na pele do cliente e reporta o que não funciona.
4. **ciberseguranca** — cria o login e blinda a segurança do sistema (OWASP).
5. **hacker** — pentester ético: tenta quebrar o sistema pronto e reporta as falhas.
6. **corretor-de-bugs** — vistoria o código e conserta bugs (construção e pós-lançamento).
7. **/gerente** — comando que orquestra tudo em pipeline simultâneo (o "gerente" da equipe).

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

```
criador-de-sites + designer  →  testador  →  ciberseguranca  →  hacker  →  🐛 corretor-de-bugs
   (pipeline: peça pronta        (testa na    (login+blindagem)  (pentest)   (vistoria + manutenção)
    já vai pro próximo)          pele do cliente)
```

Detalhes completos em [`CLAUDE.md`](./CLAUDE.md).
