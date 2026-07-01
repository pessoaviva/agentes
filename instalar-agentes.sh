#!/usr/bin/env bash
# Instala a equipe de agentes no nível do USUÁRIO (~/.claude), para que funcionem
# em QUALQUER pasta em que você abrir o Claude Code — não só neste projeto.
#
# Uso:
#   bash instalar-agentes.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_AGENTS="$HOME/.claude/agents"
DEST_COMMANDS="$HOME/.claude/commands"

echo "==> Instalando agentes em: $DEST_AGENTS"
mkdir -p "$DEST_AGENTS" "$DEST_COMMANDS"

# Copia os 4 agentes trabalhadores
for agente in criador-de-sites ciberseguranca hacker designer; do
  cp "$SCRIPT_DIR/.claude/agents/$agente.md" "$DEST_AGENTS/$agente.md"
  echo "    ✓ agente: $agente"
done

# Copia o comando /gerente (o orquestrador)
cp "$SCRIPT_DIR/.claude/commands/gerente.md" "$DEST_COMMANDS/gerente.md"
echo "    ✓ comando: /gerente"

echo ""
echo "==> Pronto! Os agentes agora funcionam em qualquer pasta."
echo "    Abra o Claude Code em qualquer projeto e use:"
echo "      /gerente                          (conduz o fluxo completo)"
echo "      \"use o agente criador-de-sites\"   (aciona um agente específico)"
echo ""
echo "    Para conferir: rode /agents dentro do Claude Code."
