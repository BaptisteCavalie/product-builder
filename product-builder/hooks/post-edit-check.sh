#!/usr/bin/env bash
# Hook PostToolUse — vérifie chaque fichier TS/JS édité, immédiatement.
# Exit 2 = Claude reçoit l'erreur sur stderr et doit corriger avant de continuer.

set -uo pipefail
INPUT=$(cat)

# Extraire le chemin du fichier édité depuis le JSON du hook
if command -v jq >/dev/null 2>&1; then
  FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*:[[:space:]]*"//;s/"$//')
fi

[ -z "${FILE:-}" ] && exit 0
case "$FILE" in
  *.ts|*.tsx|*.js|*.jsx) ;;
  *) exit 0 ;;
esac
[ -f "package.json" ] || exit 0

ERRORS=""

# ESLint sur le fichier seul (rapide)
if [ -f "node_modules/.bin/eslint" ]; then
  LINT_OUT=$(npx eslint "$FILE" 2>&1)
  if [ $? -ne 0 ]; then
    ERRORS="${ERRORS}--- ESLint ---\n${LINT_OUT}\n"
  fi
fi

if [ -n "$ERRORS" ]; then
  printf "Le fichier édité ne passe pas les vérifications. Corrige avant de continuer :\n${ERRORS}" >&2
  exit 2
fi
exit 0
