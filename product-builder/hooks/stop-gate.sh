#!/usr/bin/env bash
# Hook Stop — la gate finale. S'exécute quand Claude croit avoir terminé.
# Si une vérification échoue : exit 2 → Claude est forcé de reprendre.
# Garde-fou anti-boucle infinie : stop_hook_active + plafond d'itérations.
# Polyglotte : JS/TS (typecheck, lint, knip) si package.json, Python
# (py_compile, + ruff/mypy seulement s'ils sont configurés) si fichiers .py.

set -uo pipefail
INPUT=$(cat)
MAX_ROUNDS=3
# Compteur scopé au projet courant : un fichier global collisionnerait entre
# projets/sessions parallèles (cas courant en exécution distante).
COUNTER_FILE="/tmp/claude-stop-gate-rounds-$(printf '%s' "$PWD" | cksum | cut -d' ' -f1)"

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

FAILURES=""
run_check() { # $1 = label, $2 = commande
  OUT=$(eval "$2" 2>&1)
  if [ $? -ne 0 ]; then
    FAILURES="${FAILURES}\n--- ${1} ---\n$(echo "$OUT" | tail -30)\n"
  fi
}

# 2. Gates JS/TS — si projet Node
if [ -f "package.json" ]; then
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
fi

# 3. Gates Python — si fichiers .py versionnés
if command -v python3 >/dev/null 2>&1; then
  PY_FILES=$(git ls-files '*.py' 2>/dev/null)
  if [ -n "$PY_FILES" ]; then
    # Syntaxe de tout le repo (déterministe, rapide, zéro faux positif)
    run_check "Syntaxe (py_compile)" "echo \"$PY_FILES\" | xargs python3 -m py_compile"

    # Lint global — seulement si ruff configuré
    if command -v ruff >/dev/null 2>&1 && { [ -f "pyproject.toml" ] || [ -f "ruff.toml" ] || [ -f ".ruff.toml" ]; }; then
      run_check "Lint (ruff)" "ruff check ."
    fi

    # Types — seulement si mypy configuré
    if command -v mypy >/dev/null 2>&1 && { [ -f "mypy.ini" ] || [ -f ".mypy.ini" ] || grep -q "\[tool.mypy\]" pyproject.toml 2>/dev/null; }; then
      run_check "Types (mypy)" "mypy ."
    fi
  fi
fi

# 4. Gates spécifiques au repo du kit.
#    a) Cohérence de la bibliothèque d'exemplaires.
#    Le script s'auto-garde (no-op hors du repo du kit), on peut l'appeler à sec.
if [ -x "${CLAUDE_PLUGIN_ROOT:-}/scripts/check-exemplars.sh" ]; then
  run_check "Bibliothèque d'exemplaires" "\"${CLAUDE_PLUGIN_ROOT}/scripts/check-exemplars.sh\""
elif [ -x "product-builder/scripts/check-exemplars.sh" ]; then
  run_check "Bibliothèque d'exemplaires" "product-builder/scripts/check-exemplars.sh"
fi
#    b) Cohérence des doctrines multi-fichiers — la gate dont l'oubli a déjà
#    coûté un incident restait la seule manuelle. Uniquement via la copie de
#    travail en cwd (session kit) : valider le cache installé depuis un projet
#    consommateur serait un no-op coûteux (on valide la source, pas l'installé).
if [ -x "product-builder/scripts/check-doctrine.sh" ]; then
  run_check "Doctrines multi-fichiers" "product-builder/scripts/check-doctrine.sh"
fi

if [ -n "$FAILURES" ]; then
  echo $((ROUNDS + 1)) > "$COUNTER_FILE"
  printf "GATE ÉCHOUÉE (tour %s/%s). Le travail n'est pas terminé tant que ces vérifications ne passent pas :\n%b\nCorrige, puis le travail sera re-vérifié automatiquement. Si tour %s/%s atteint sans succès : rédige un rapport d'escalade au lieu de continuer.\n" "$((ROUNDS + 1))" "$MAX_ROUNDS" "$FAILURES" "$MAX_ROUNDS" "$MAX_ROUNDS" >&2
  exit 2
fi

rm -f "$COUNTER_FILE"
exit 0
