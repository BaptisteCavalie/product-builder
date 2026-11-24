#!/usr/bin/env bash
# telemetry-summary.sh — synthèse déterministe de telemetry/runs.jsonl.
#
# /retro §5 doit repérer « même dimension faible sur ≥3 runs » et mesurer si un
# amendement a servi. Le faire à l'œil sur un JSONL qui grossit = erreurs de
# comptage et contexte gaspillé. Ce script rend le compte, /retro l'interprète.
# À lancer côté PROJET.
#
# Usage : telemetry-summary.sh [runs.jsonl] [N derniers runs, défaut 10]
# Exit 0 = synthèse imprimée · 2 = usage / jq absent.

set -uo pipefail
FILE="${1:-telemetry/runs.jsonl}"
N="${2:-10}"

command -v jq >/dev/null 2>&1 || { echo "jq requis (brew install jq)." >&2; exit 2; }
[ -f "$FILE" ] || { echo "Pas de télémétrie : $FILE introuvable." >&2; exit 2; }

# Lignes invalides signalées plutôt qu'ignorées en silence.
BAD=$(grep -cv '^[[:space:]]*$' "$FILE" 2>/dev/null)
VALID=$(jq -c '.' "$FILE" 2>/dev/null | wc -l | tr -d ' ')
[ "$BAD" != "$VALID" ] && echo "⚠ $FILE contient des lignes JSON invalides ($VALID valides sur $BAD) — corrige-les." >&2

jq -rs --argjson n "$N" '
  (map(select(type=="object"))) as $all
  | ($all | .[-$n:]) as $w
  | "Runs : \($all|length) au total — fenêtre analysée : \($w|length) derniers",
    "Par type : " + ([$all[] | .type // "?"] | group_by(.) | map("\(.[0])=\(length)") | join(", ")),
    "Fenêtre — blockers \([$w[].blockers // 0]|add // 0) · majors \([$w[].majors // 0]|add // 0) · minors \([$w[].minors // 0]|add // 0) · nits \([$w[].nits // 0]|add // 0)",
    "Escalades (fenêtre) : \([$w[] | select(.escalade == true)] | length)",
    "Tours de boucle moyens (feature) : \([$w[] | select(.type=="feature") | .tours // 0] | if length>0 then (add/length*10|round/10) else "n/a" end)",
    "",
    "Dimensions faibles (fenêtre, ≥3 = trou structurel probable) :",
    ([$w[] | .dimensions_faibles // [] | .[]] | group_by(.) | map({d: .[0], c: length}) | sort_by(-.c)
      | if length == 0 then ["  (aucune)"] else map("  \(if .c >= 3 then "⚠" else " " end) \(.d) : \(.c)") end | .[])
' "$FILE"
