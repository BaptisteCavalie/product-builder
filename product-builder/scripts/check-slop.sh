#!/usr/bin/env bash
# check-slop.sh — gate déterministe des interdits anti-slop machine-vérifiables
# (les lignes marquées ⚙ dans skills/anti-slop/SKILL.md). Branché sur le hook
# PostToolUse via post-edit-check.sh : chaque fichier édité est scanné.
#
# Ne juge que ce qu'un grep peut prouver — la passe énumérée LLM (build +
# critique) reste la vérification de fond ; cette gate rattrape l'oubli.
# Philosophie du kit : « gate déterministe, pas seulement la vigilance »,
# appliquée à sa propre liste d'interdits.
#
# Waiver : un commentaire `slop-ok: AS-XXX — raison` neutralise sa propre
# ligne ET la suivante (en JSX le commentaire vit au-dessus de la ligne
# visée) — même règle que @ts-ignore : jamais sans justification écrite.
#
# Usage : check-slop.sh <fichier> [...]
# Exit 0 = rien à signaler · 1 = interdit détecté.
# S'auto-garde : extensions non concernées et fichiers-source de tokens
# (@theme / :root, qui portent légitimement des valeurs brutes) → no-op.

set -uo pipefail
FOUND=0

scan() { # $1=ID anti-slop  $2=regex (grep -E)  $3=libellé court
  local hits
  hits=$(printf '%s\n' "$FILTERED" | grep -nE -- "$2" | head -5)
  if [ -n "$hits" ]; then
    FOUND=1
    printf '%s — %s\n%s\n' "$1" "$3" "$hits" | sed "2,\$s|^|  $f:|"
  fi
}

for f in "$@"; do
  [ -f "$f" ] || continue

  # Surfaces concernées uniquement.
  case "$f" in
    *.ts|*.tsx|*.js|*.jsx|*.css|*.scss|*.html|*.svelte|*.vue) ;;
    *) continue ;;
  esac

  # Le fichier-source des tokens (@theme ou :root du projet, template du kit)
  # porte légitimement des valeurs brutes : on ne le scanne pas.
  if grep -qE '@theme|^[[:space:]]*:root' "$f"; then
    continue
  fi

  # Neutralise les lignes waivées (slop-ok) et leur ligne suivante, en
  # préservant les numéros de ligne (lignes vidées, pas supprimées).
  FILTERED=$(awk '
    index($0, "slop-ok:") > 0 { skipnext = 1; print ""; next }
    skipnext == 1             { skipnext = 0; print ""; next }
    { print }
  ' "$f")

  scan "AS-C01" '#[0-9a-fA-F]{6}\b|#[0-9a-fA-F]{3}\b' \
    "couleur hex en dur (les valeurs vivent dans le @theme, pas dans les composants)"
  scan "AS-C01" '\b(rgba?|hsla?|oklch)\(' \
    "couleur littérale (rgb/hsl/oklch) hors du fichier de tokens"
  scan "AS-C01" '(transition|animation)[^;{}"'"'"']*[0-9]+m?s|['"'"'"][0-9]+ms['"'"'"]|\bduration-\[?[0-9]+' \
    "durée de motion en dur (utiliser --duration-* / --ease-*)"
  scan "AS-C02" '\b(linear|radial|conic)-gradient\(|bg-gradient-to-' \
    "gradient (décoratif par défaut — justification DA brief requise)"
  scan "AS-C04" '(border-left|borderLeft)[^;{}]*(#|rgba?\(|hsla?\(|oklch\(|var\(--color-accent)|border-l-[0-9]' \
    "bordure d'accent à gauche d'une card/callout"
  scan "AS-IC04" '✨' \
    "sparkles / imagerie « magie IA »"
  scan "AS-CY05" 'Oops|Something went wrong|Une erreur est survenue' \
    "message d'erreur générique qui ne dit pas quoi faire"
  scan "AS-CY06" 'Aucune donnée|Rien à afficher|\bNo data\b' \
    "empty state qui constate au lieu de guider"
  scan "AS-CY09" '[Ll]orem ipsum' \
    "texte de remplissage shippé"
done

if [ "$FOUND" -ne 0 ]; then
  cat >&2 <<'EOF'
Interdits anti-slop détectés (détail ci-dessus). Corriger, ou si le cas est
réellement justifié par le DA brief, poser un waiver sur la ligne :
  /* slop-ok: AS-XXX — justification */
Référence : skills/anti-slop/SKILL.md (chaque ID y est défini).
EOF
  exit 1
fi
exit 0
