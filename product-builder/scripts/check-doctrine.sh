#!/usr/bin/env bash
# check-doctrine.sh — gate déterministe de cohérence doctrinale du kit.
#
# Les doctrines multi-fichiers du kit DOIVENT rester alignées : deux
# formulations divergentes = incident (cf. CLAUDE.md). Jusqu'ici cet alignement
# ne reposait que sur la discipline humaine. Ce script en fait une gate :
# il vérifie que chaque fichier porteur d'une doctrine contient ses marqueurs.
#
# Il ne prouve PAS l'équivalence sémantique — il attrape la dérive grossière
# (un fichier oublié dans un commit, un marqueur supprimé) que la prose laissait
# passer. C'est un tripwire, pas un juge. À lancer avant tout push du kit.
#
# Exit 0 = aligné · Exit 1 = un marqueur manque.

set -uo pipefail
# Le script vit dans product-builder/scripts/ ; la doctrine couvre aussi des
# fichiers hors du dossier plugin (README racine, CLAUDE.md, project-template/),
# donc la racine de référence est le repo, deux crans au-dessus.
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"
FAIL=0

req() { # $1=fichier  $2=regex (grep -Ei)  $3=doctrine
  if [ ! -f "$1" ]; then
    echo "✗ [$3] fichier manquant : $1"; FAIL=1; return
  fi
  if ! grep -Eqi -- "$2" "$1"; then
    echo "✗ [$3] marqueur absent dans $1 : /$2/"; FAIL=1
  fi
}

echo "→ Doctrine tokens (@theme compilé / :root agnostique, 7 fichiers)"
TOKENS_FILES="
product-builder/design-system/README.md
product-builder/design-system/tokens.css
product-builder/constitution.md
product-builder/commands/feature.md
product-builder/agents/design-critic.md
project-template/CLAUDE.md
README.md
"
for f in $TOKENS_FILES; do
  req "$f" '@theme'  "tokens"
  req "$f" ':root'   "tokens"
done

echo "→ Doctrine visual-craft (format couleur oklch web / HEX repli)"
req product-builder/skills/color/SKILL.md          'oklch' "visual-craft"
req product-builder/skills/color/SKILL.md          'hex'   "visual-craft"
req product-builder/design-system/tokens.css       'oklch' "visual-craft"
req product-builder/design-system/tokens.css       'hex'   "visual-craft"
# Les deux skills porteurs gardent leur noyau
req product-builder/skills/color/SKILL.md          'rampe'     "visual-craft"
req product-builder/skills/art-direction/SKILL.md  'retenue'   "visual-craft"
req product-builder/skills/art-direction/SKILL.md  'signature' "visual-craft"
# Le design-critic garde les deux blocs qui vérifient la doctrine
req product-builder/agents/design-critic.md 'Couleur & système'   "visual-craft"
req product-builder/agents/design-critic.md 'Composition & motion' "visual-craft"

echo "→ Doctrine motion (durées/easings en tokens --duration-*/--ease-*)"
req product-builder/design-system/tokens.css      'duration-micro' "motion"
req product-builder/skills/art-direction/SKILL.md 'duration-'      "motion"
req product-builder/agents/design-critic.md       'duration-'      "motion"
req product-builder/constitution.md               'easing'         "motion"

echo "→ Doctrine dark (rampe sombre dédiée, jamais une inversion)"
req product-builder/design-system/tokens.css      'inversion' "dark"
req product-builder/design-system/README.md       'inversion' "dark"
req product-builder/skills/color/SKILL.md         'inversion' "dark"

echo "→ Doctrine curseur d'audace (lever showcase↔sobre, da + art-direction)"
req product-builder/commands/da.md                 "curseur d'audace" "curseur-audace"
req product-builder/skills/art-direction/SKILL.md  "curseur d'audace" "curseur-audace"

echo "→ Doctrine pistes (choix structurant = 2-3 pistes sourcées, Baptiste tranche)"
PISTES_FILES="
product-builder/constitution.md
product-builder/commands/da.md
product-builder/skills/ui-resources/SKILL.md
"
for f in $PISTES_FILES; do
  req "$f" 'pistes sourcées'   "pistes"
  req "$f" 'choix structurant' "pistes"
done
req product-builder/commands/feature.md 'choix structurant' "pistes"
# Le menu meurt à l'arbitrage : le brief écrit ne porte qu'UNE direction.
req product-builder/commands/da.md 'jamais un menu' "pistes"

echo "→ Doctrine ressources UI (catalogue routé, ce qu'on vole / ce qu'on laisse)"
req product-builder/skills/ui-resources/SKILL.md "ce qu'on vole"   "ressources"
req product-builder/skills/ui-resources/SKILL.md "ce qu'on laisse" "ressources"
req product-builder/commands/da.md               'ui-resources'    "ressources"
req product-builder/commands/feature.md          'ui-resources'    "ressources"
req product-builder/agents/pattern-researcher.md 'ui-resources'    "ressources"

echo "→ Source Inspo (MCP) — câblée aux 4 endroits qui la consomment"
INSPO_FILES="
product-builder/skills/ui-resources/SKILL.md
product-builder/commands/da.md
product-builder/agents/design-critic.md
product-builder/agents/pattern-researcher.md
"
for f in $INSPO_FILES; do
  req "$f" 'inspo' "inspo"
done
# Le critic ne peut interroger Inspo que si le serveur s'appelle bien « inspo ».
req product-builder/agents/design-critic.md 'mcp__inspo__' "inspo"

echo "→ Doctrine métier (référence = noyau régulé, les conventions UI passent en pistes)"
req product-builder/constitution.md                                         'noyau régulé'     "metier"
req product-builder/skills/domain-knowledge/SKILL.md                        'noyau régulé'     "metier"
METIER_FILES="
product-builder/skills/domain-knowledge/references/_template.md
product-builder/skills/domain-knowledge/references/fintech.md
product-builder/skills/domain-knowledge/references/paris-sportifs.md
"
for f in $METIER_FILES; do
  req "$f" 'impose aux pistes' "metier"
done

echo "→ Doctrine /retro (une session projet ne mute jamais le kit)"
req CLAUDE.md                          'ne mute JAMAIS le kit' "retro"
req product-builder/commands/retro.md  'ne mute'               "retro"

if [ "$FAIL" -ne 0 ]; then
  echo
  echo "DOCTRINE DÉSALIGNÉE — corrige les fichiers ci-dessus dans le même commit."
  echo "Rappel : deux formulations divergentes d'une même doctrine = incident."
  exit 1
fi
echo "✓ Doctrines alignées."
