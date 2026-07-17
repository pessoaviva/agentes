#!/usr/bin/env bash
# Sincroniza as fontes canônicas (agents/ e commands/) para a cópia .claude/
# usada pela Forma 3 (pasta .claude/ dentro do projeto — Claude Code na nuvem).
#
# Fluxo de manutenção: edite SEMPRE em agents/ e commands/, rode este script e
# comite as duas cópias juntas (e suba a version em .claude-plugin/*.json).
#
# Uso:
#   bash sincronizar.sh
set -euo pipefail

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p .claude/agents .claude/commands

# Remove só os .md da cópia (arquivos renomeados/apagados não ficam órfãos)
rm -f .claude/agents/*.md .claude/commands/*.md

cp agents/*.md .claude/agents/
cp commands/*.md .claude/commands/

echo "==> .claude/ sincronizada com agents/ e commands/:"
ls .claude/agents .claude/commands
