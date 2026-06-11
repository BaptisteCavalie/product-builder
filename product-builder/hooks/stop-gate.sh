#!/usr/bin/env bash
# Hook Stop — la gate finale. S'exécute quand Claude croit avoir terminé.
# Si une vérification échoue : exit 2 → Claude est forcé de reprendre.
# Garde-fou anti-boucle infinie : stop_hook_active + plafond d'itérations.

set -uo pipefail
INPUT=$(cat)
MAX_ROUNDS=3
COUNTER_FILE="/tmp/claude-stop-gate-rounds"

# 1. Anti-boucle : si on est déjà dans une continuation déclenchée par ce hook
#    ET que le plafond est atteint, on laisse passer (l'agent doit alors escalader).
if command -v jq >/dev/null 2>&1; then
  ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false')
else
  ACTIVE=$(echo "$INPUT" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true' && echo true || echo false)
fi

ROUNDS=0
[ -f "$COUNTER_FILE" ] && ROUNDS=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
if [ "$ACTIVE" = "true" ] && [ "$ROUNDS" -ge "$MAX_ROUNDS" ]; then
  rm -f "$COUNTER_FILE"
  exit 0
fi
[ "$ACTIVE" != "true" ] && ROUNDS=0

# 2. Rien à vérifier hors projet JS/TS
[ -f "package.json" ] || exit 0

FAILURES=""
run_check() { # $1 = label, $2 = commande
  OUT=$(eval "$2" 2>&1)
  if [ $? -ne 0 ]; then
    FAILURES="${FAILURES}\n--- ${1} ---\n$(echo "$OUT" | tail -30)\n"
  fi
}

# Typecheck (script dédié ou tsc direct)
if grep -q '"typecheck"' package.json; then
  run_check "Typecheck" "npm run -s typecheck"
elif [ -f "tsconfig.json" ] && [ -f "node_modules/.bin/tsc" ]; then
  run_check "Typecheck" "npx tsc --noEmit"
fi

# Lint global
if grep -q '"lint"' package.json; then
  run_check "Lint" "npm run -s lint"
fi

# Code mort (knip, seulement s'il est configuré dans le projet)
if [ -f "knip.json" ] || grep -q '"knip"' package.json; then
  run_check "Code mort (knip)" "npx knip --no-progress"
fi

if [ -n "$FAILURES" ]; then
  echo $((ROUNDS + 1)) > "$COUNTER_FILE"
  printf "GATE ÉCHOUÉE (tour %s/%s). Le travail n'est pas terminé tant que ces vérifications ne passent pas :\n%b\nCorrige, puis le travail sera re-vérifié automatiquement. Si tour %s/%s atteint sans succès : rédige un rapport d'escalade au lieu de continuer.\n" "$((ROUNDS + 1))" "$MAX_ROUNDS" "$FAILURES" "$MAX_ROUNDS" "$MAX_ROUNDS" >&2
  exit 2
fi

rm -f "$COUNTER_FILE"
exit 0
