#!/usr/bin/env bash
# Cohérence de la bibliothèque d'exemplaires (design-system/references).
# Garde-fou déterministe du handoff /retro → kit : rend IMPOSSIBLE de committer
# une ligne d'index « fantôme » (image annoncée mais jamais déposée) ou un .png
# orphelin (image sans le « pourquoi »). Branché sur le Stop hook en session kit.
#
# No-op hors du repo du kit : la lib est cherchée relativement au cwd (la copie
# de travail qu'on s'apprête à committer, pas le cache d'install) ; absente, on
# sort 0. C'est voulu que ce script raisonne en cwd-relatif, pas en
# ${CLAUDE_PLUGIN_ROOT} : il valide la source, pas l'installé.
#
# Index « live » = ligne du README hors commentaire, commençant par "- " et
# nommant un <…>.png. Les captures en attente vivent dans un bloc commenté HTML
# (<!-- … -->) tant que leur .png manque : elles ne comptent pas.

set -uo pipefail

# 1. Localiser la lib (kit-dev depuis la racine ou depuis product-builder/).
REF_DIR=""
for c in "product-builder/design-system/references" "design-system/references"; do
  if [ -f "$c/README.md" ]; then REF_DIR="$c"; break; fi
done
[ -z "$REF_DIR" ] && exit 0

README="$REF_DIR/README.md"

# 2. Index live : on retire les blocs commentés HTML, puis on extrait les noms
#    de .png des lignes "- ….png — …".
INDEXED=$(awk '
  /<!--/ { inc=1 }
  inc==0 { print }
  /-->/  { inc=0 }
' "$README" \
  | grep -oE '^- [^ ]+\.png' \
  | sed 's/^- //' \
  | sort -u)

# 3. Fichiers .png réellement présents.
PRESENT=$(cd "$REF_DIR" && ls -1 ./*.png 2>/dev/null | sed 's#^\./##' | sort -u)

MISSING=""   # indexé mais absent du disque = ligne fantôme
ORPHAN=""    # présent mais non indexé = image sans pourquoi

while IFS= read -r f; do
  [ -z "$f" ] && continue
  printf '%s\n' "$PRESENT" | grep -qxF "$f" || MISSING="${MISSING}  - ${f} (ligne d'index sans fichier)\n"
done <<EOF
$INDEXED
EOF

while IFS= read -r f; do
  [ -z "$f" ] && continue
  printf '%s\n' "$INDEXED" | grep -qxF "$f" || ORPHAN="${ORPHAN}  - ${f} (fichier sans ligne d'index)\n"
done <<EOF
$PRESENT
EOF

if [ -n "$MISSING" ] || [ -n "$ORPHAN" ]; then
  printf "Bibliothèque d'exemplaires incohérente (%s) :\n" "$REF_DIR" >&2
  [ -n "$MISSING" ] && printf "Annoncées dans l'index, absentes du dossier :\n%b" "$MISSING" >&2
  [ -n "$ORPHAN" ]  && printf "Présentes dans le dossier, absentes de l'index :\n%b" "$ORPHAN" >&2
  printf "Règle : une ligne d'index ne devient « live » qu'une fois son .png déposé dans le MÊME commit ; tant que la capture manque, son « pourquoi » attend dans le bloc commenté « En attente de capture ».\n" >&2
  exit 1
fi
exit 0
