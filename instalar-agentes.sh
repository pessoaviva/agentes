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

# Copia os 6 agentes trabalhadores
for agente in criador-de-sites ciberseguranca hacker designer corretor-de-bugs testador; do
  cp "$SCRIPT_DIR/agents/$agente.md" "$DEST_AGENTS/$agente.md"
  echo "    ✓ agente: $agente"
done

# Copia o comando /gerente (o orquestrador)
cp "$SCRIPT_DIR/commands/gerente.md" "$DEST_COMMANDS/gerente.md"
echo "    ✓ comando: /gerente"

echo ""
echo "==> Pronto! Os agentes agora funcionam em qualquer pasta."
echo "    Abra o Claude Code em qualquer projeto e use:"
echo "      /gerente                          (conduz o fluxo completo)"
echo "      \"use o agente criador-de-sites\"   (aciona um agente específico)"
echo ""
echo "    Para conferir: rode /agents dentro do Claude Code."
