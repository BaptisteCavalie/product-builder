#!/usr/bin/env bash
# Capture une référence visuelle en image, pour /da et pattern-researcher.
# Rend la VRAIE page (Playwright headless), là où `curl` d'og:image renvoie
# souvent un logo générique ou rien — la capture est la norme (cf. commands/da.md).
#
# Usage : capture-ref.sh <url> <chemin-sortie.png> [--full-page]
#   ex.  : capture-ref.sh https://linear.app design/references/linear-home.png
#
# Succès : écrit le PNG et imprime son chemin sur stdout.
# Échec  : message de repli sur stderr + exit 1 — l'appelant note alors la
#          limite dans le rapport et se rabat sur URL + requête exacte.

set -uo pipefail

URL="${1:-}"
OUT="${2:-}"
FULLPAGE="${3:-}"
VIEWPORT="1440,900"

if [ -z "$URL" ] || [ -z "$OUT" ]; then
  echo "usage: capture-ref.sh <url> <chemin-sortie.png> [--full-page]" >&2
  exit 2
fi

# S'assurer que le dossier cible existe (ex. design/references/).
mkdir -p "$(dirname "$OUT")"

ARGS=(playwright screenshot --viewport-size="$VIEWPORT")
[ "$FULLPAGE" = "--full-page" ] && ARGS+=(--full-page)
ARGS+=("$URL" "$OUT")

# Playwright via npx (auto-fetch du paquet si absent). Si la capture casse, on
# le dit clairement plutôt que de laisser croire à une réussite.
if ! npx --yes "${ARGS[@]}" >/dev/null 2>&1; then
  cat >&2 <<EOF
Capture Playwright impossible pour : $URL
Repli : signale-le comme limite dans le rapport, et garde URL + requête exacte
pour retrouver la référence. Causes fréquentes :
  - navigateurs Playwright non installés → \`npx playwright install chromium\`
  - page authentifiée (Linear, etc.) — capture manuelle requise
  - réseau restreint par la policy de l'environnement
EOF
  exit 1
fi

# Garde-fou : un fichier vide = échec silencieux, on le traite comme tel.
if [ ! -s "$OUT" ]; then
  echo "Capture vide ($OUT) — traite comme un échec, repli URL + requête." >&2
  rm -f "$OUT"
  exit 1
fi

echo "$OUT"
