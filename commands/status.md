---
description: Mostra onde o projeto parou — fase atual, quadro de peças, pendências e o próximo passo — lendo docs/ESTADO.md (e docs/relatorios/ se precisar), sem gastar nenhum subagente.
---

# /status — onde paramos?

Você (a IA principal) responde AGORA, inline, **sem acionar nenhum subagente** — este
comando é leitura barata, não trabalho.

> **Par perfeito com a limpeza de contexto:** nos portões de fase, o usuário pode rodar
> `/clear` (ou `/compact`) sem medo — o `ESTADO.md` guarda tudo — e usar `/status` para
> retomar em segundos com a janela zerada. É assim que projeto longo fica barato.

1. Leia `docs/ESTADO.md`. **Se não existir**, diga que o fluxo ainda não começou neste
   projeto e sugira rodar `/gerente` (ou `/agentes:gerente`) — e pare por aqui.
2. Se precisar do detalhe de um relatório antigo, consulte `docs/relatorios/` — só o
   arquivo necessário.
3. Responda curto e escaneável:
   - **Fase atual** (0–6) e **o que falta para o portão dela passar**.
   - **Quadro de peças:** prontas ✅ / em andamento 🔄 / na fila ⏳ (resumido).
   - **Última entrega** (1 linha: qual agente, o quê).
   - **Pendências e dúvidas em aberto** (seção 7 do ESTADO.md) que dependem do usuário.
   - **Próximo passo recomendado** (1 linha: qual agente acionar ou o que decidir).
4. **Não atualize o `ESTADO.md` neste comando** — /status é só leitura. Se o usuário
   decidir algo a partir do status, aí sim o fluxo normal (gerente) registra.
