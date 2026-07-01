# agentes

Equipe de **5 agentes de IA** para o Claude Code, para criar sites e sistemas (simples
ou complexos) de ponta a ponta, com a inteligência do modelo que você usar (Opus 4.8 /
Fable 5).

## Os 5 agentes

1. **criador-de-sites** — escreve todo o código-fonte (lógica, back-end, banco, APIs).
2. **designer** — cria todo o front-end e o design (nível "Claude design").
3. **ciberseguranca** — cria o login e blinda a segurança do sistema (OWASP).
4. **hacker** — pentester ético: tenta quebrar o sistema pronto e reporta as falhas.
5. **/gerente** — comando que orquestra tudo na ordem certa (o "gerente" da equipe).

## Início rápido

```bash
# 1. Rodar só neste projeto: já funciona (os agentes estão em .claude/)
#    Abra o Claude Code nesta pasta e digite:  /gerente

# 2. Rodar em QUALQUER pasta (instala no nível do usuário):
bash instalar-agentes.sh
```

Depois é só, dentro do Claude Code:

- `/gerente` → conduz o fluxo completo (construção + design → segurança → pentest).
- ou acionar um agente direto: *"use o agente criador-de-sites para..."*.

## Fluxo de trabalho

```
criador-de-sites + designer  →  ✅ sistema pronto  →  ciberseguranca  →  hacker (loop até ficar limpo)
       (lógica + visual em paralelo)                    (login + blindagem)   (acha falhas → corrige → testa de novo)
```

Detalhes completos em [`CLAUDE.md`](./CLAUDE.md).
