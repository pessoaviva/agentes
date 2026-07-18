#!/usr/bin/env bash
# Instala a equipe de agentes no nível do USUÁRIO (~/.claude), para que funcionem
# em QUALQUER pasta/projeto em que você abrir o Claude Code — sem plugin.
#
# Vantagem deste método: o comando fica /gerente (sem prefixo).
# Alternativa (recomendada para atualizar fácil): instalar como plugin. Veja o README.
#
# Uso:
#   bash instalar-agentes.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_AGENTS="$HOME/.claude/agents"
DEST_COMMANDS="$HOME/.claude/commands"

echo "==> Instalando agentes em: $DEST_AGENTS"
mkdir -p "$DEST_AGENTS" "$DEST_COMMANDS"

# Copia todos os agentes trabalhadores (glob: um agente novo/renomeado entra sozinho)
for arquivo in "$SCRIPT_DIR"/agents/*.md; do
  cp "$arquivo" "$DEST_AGENTS/$(basename "$arquivo")"
  echo "    ✓ agente: $(basename "$arquivo" .md)"
done

# Copia todos os comandos (/gerente, /retomar, ...)
for arquivo in "$SCRIPT_DIR"/commands/*.md; do
  cp "$arquivo" "$DEST_COMMANDS/$(basename "$arquivo")"
  echo "    ✓ comando: /$(basename "$arquivo" .md)"
done

echo ""
echo "==> Pronto! Os agentes agora funcionam em qualquer pasta."
echo "    Abra o Claude Code em qualquer projeto e use:"
echo "      /gerente                          (conduz o fluxo completo)"
echo "      /retomar                          (onde o projeto parou)"
echo "      \"use o agente criador-de-sites\"   (aciona um agente específico)"
echo ""
echo "    Para conferir: rode /agents dentro do Claude Code."
