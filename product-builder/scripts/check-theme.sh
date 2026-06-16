#!/usr/bin/env bash
# check-theme.sh — valide qu'un entrypoint CSS de projet matérialise bien
# TOUTES les catégories du contrat de tokens du kit.
#
# Le contrat (design-system/tokens.css) est un template jamais compilé ; chaque
# projet re-matérialise les valeurs dans le @theme (ou :root) de son entrypoint.
# Rien ne garantissait que le projet couvre toutes les catégories ni n'utilise
# les bons noms : dérive silencieuse jusqu'à ce qu'un critic la voie à l'œil.
# Ce script rend le contrat vérifiable. À lancer côté PROJET.
#
# Usage : check-theme.sh <chemin-vers-entrypoint-css>   (ex. app/globals.css)
# Exit 0 = toutes les catégories couvertes · 1 = token manquant · 2 = usage.

set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$ROOT/design-system/tokens.css"
TARGET="${1:-}"

if [ -z "$TARGET" ] || [ ! -f "$TARGET" ]; then
  echo "Usage: $0 <entrypoint-css>  (le fichier qui porte le @theme ou :root du projet)"
  exit 2
fi
if [ ! -f "$CONTRACT" ]; then
  echo "Contrat introuvable : $CONTRACT"; exit 2
fi

MISSING=0
# Noms de variables --xxx déclarés dans le contrat (catégories à matérialiser)
while IFS= read -r tok; do
  [ -z "$tok" ] && continue
  grep -q -- "$tok" "$TARGET" || { echo "✗ catégorie de token absente du projet : $tok"; MISSING=1; }
done < <(grep -oE '^[[:space:]]*--[a-z0-9-]+' "$CONTRACT" | sed -E 's/^[[:space:]]+//' | sort -u)

if [ "$MISSING" -eq 0 ]; then
  echo "✓ Le @theme du projet couvre toutes les catégories du contrat de tokens."
fi
exit "$MISSING"
