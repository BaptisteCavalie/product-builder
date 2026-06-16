#!/usr/bin/env bash
# Hook PostToolUse — vérifie chaque fichier édité, immédiatement.
# Exit 2 = Claude reçoit l'erreur sur stderr et doit corriger avant de continuer.
# Polyglotte : TS/JS (ESLint si présent) et Python (py_compile + ruff si configuré).

set -uo pipefail
INPUT=$(cat)

# Extraire le chemin du fichier édité depuis le JSON du hook
if command -v jq >/dev/null 2>&1; then
  FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*:[[:space:]]*"//;s/"$//')
fi

[ -z "${FILE:-}" ] && exit 0
[ -f "$FILE" ] || exit 0

ERRORS=""

case "$FILE" in
  *.ts|*.tsx|*.js|*.jsx)
    [ -f "package.json" ] || exit 0
    # ESLint sur le fichier seul (rapide)
    if [ -f "node_modules/.bin/eslint" ]; then
      # --quiet : seules les ERREURS bloquent (exit 2). Les warnings préexistants
      # d'un fichier touché pour une autre raison ne doivent pas couper la boucle.
      LINT_OUT=$(npx eslint --quiet "$FILE" 2>&1)
      if [ $? -ne 0 ]; then
        ERRORS="${ERRORS}--- ESLint ---\n${LINT_OUT}\n"
      fi
    fi
    ;;
  *.py)
    # Syntaxe (déterministe, zéro faux positif, aucune config requise)
    COMPILE_OUT=$(python3 -m py_compile "$FILE" 2>&1)
    if [ $? -ne 0 ]; then
      ERRORS="${ERRORS}--- py_compile ---\n${COMPILE_OUT}\n"
    fi
    # Lint optionnel : seulement si ruff est installé ET configuré dans le repo
    if command -v ruff >/dev/null 2>&1 && { [ -f "pyproject.toml" ] || [ -f "ruff.toml" ] || [ -f ".ruff.toml" ]; }; then
      LINT_OUT=$(ruff check "$FILE" 2>&1)
      if [ $? -ne 0 ]; then
        ERRORS="${ERRORS}--- ruff ---\n${LINT_OUT}\n"
      fi
    fi
    ;;
  *) exit 0 ;;
esac

if [ -n "$ERRORS" ]; then
  printf "Le fichier édité ne passe pas les vérifications. Corrige avant de continuer :\n${ERRORS}" >&2
  exit 2
fi
exit 0
