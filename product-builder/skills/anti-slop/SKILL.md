---
name: anti-slop
description: Liste des interdits visuels à vérifier sur TOUT output UI avant de le considérer terminé — composants, pages, emails, slides, SVG. Déclencher systématiquement en phase de build ET de critique, sur toute génération visuelle sans exception.
---

# Anti-slop

Le slop naît de l'absence de contraintes. Ce fichier EST la contrainte (le
plancher : ce qu'on ne fait jamais). Le plafond — ce qu'on fait bien — vit
dans `art-direction` et `color`. Chaque interdit est vérifiable en oui/non. Ce
fichier s'enrichit via /retro : chaque correction de goût de Baptiste devient
une règle ici.

## Interdits absolus

**Couleur**
- ❌ Toute valeur hors tokens (`#FACC15`, `bg-yellow-400` hors système…).
- ❌ Gradients décoratifs (sur CTA, titres, fonds de cards, bordures).
- ❌ Le combo violet/indigo + fond sombre + glow "AI product".
- ❌ Bordures colorées d'accent à gauche des cards/callouts.
- ❌ Une couleur différente par item de liste/catégorie "pour faire vivant".
- ❌ Accent utilisé en décoration (fonds, icônes passives) plutôt qu'en signal.

**Typographie**
- ❌ Plus de 2 graisses par écran.
- ❌ Alternance de graisses dans une même phrase pour "dynamiser".
- ❌ Mots isolés en couleur d'accent au milieu d'un titre.
- ❌ Tout en capitales sur plus de 3 mots (hors micro-labels avec letter-spacing).
- ❌ Tailles de police hors échelle des tokens.

**Composition**
- ❌ Ombres portées sur les cards de contenu statique — l'élévation est réservée
  aux éléments flottants (modale, dropdown, toast).
- ❌ Border + ombre + fond teinté cumulés sur un même conteneur (choisir UN
  séparateur, ou juste l'espace).
- ❌ Coins arrondis incohérents (un seul radius de tokens par famille de composants).
- ❌ Conteneurs encadrés imbriqués — pas seulement les "cards" : un parent déjà
  délimité (card, `.panel`, `<details>`/disclosure, modale, accordéon) ne
  contient JAMAIS d'enfants avec leur propre bordure + radius. Les enfants sont
  à plat ; pour différencier, on change le FOND (surface recessed), jamais on
  ajoute une 2e bordure. Test : aucun coin arrondi à l'intérieur d'un coin arrondi.
- ❌ La grille de 3 cards "features" avec icône centrée + titre + paragraphe,
  par réflexe — ce pattern doit être justifié, pas défaut.

**Iconographie & ornement**
- ❌ Emojis comme icônes ou puces dans l'UI produit.
- ❌ Icône devant CHAQUE titre, item de menu ou cellule — l'icône doit ajouter
  du sens, sinon rien.
- ❌ Illustrations 3D génériques type "blob people" / memphis / isométrique stock.
- ❌ Sparkles ✨ et toute imagerie "magie IA".

**Copy**
- ❌ "Supercharge", "Unleash", "Seamless", "Effortless", "Élevez votre…",
  "Boostez", "révolutionnaire" et tout superlatif vide.
- ❌ Point d'exclamation dans l'UI (réservé aux vraies célébrations, max 1).
- ❌ Tirets cadratins en cascade et tournures "It's not just X, it's Y".

**Layout**
- ❌ Hero centré + badge pilule "New ✨" + titre 3 lignes + 2 CTA côte à côte,
  par défaut — encore une fois : possible si justifié, interdit par réflexe.
- ❌ Sections alternées image-gauche/image-droite sur toute une landing.

**Défauts statistiques**
- ❌ Le look "Tailwind par défaut" shippé tel quel : police système/Inter +
  fond gray-50 + cards blanches + shadow-sm + rounded-xl + accent bleu.
  Chaque élément est légal isolément ; l'ensemble par réflexe, sans DA brief
  qui le justifie, est le slop le plus répandu — la propreté n'excuse pas
  l'absence de direction.
- ❌ Typographie subie "parce qu'elle est là" — la police du projet est NOMMÉE
  dans `design/da.md`, choisie pour l'ambiance, jamais par défaut.
- ❌ Construire de l'UI sans DA brief (`design/da.md`) : sans direction
  déclarée, chaque choix retombe sur la moyenne statistique. /da d'abord.

## Le test final — deux questions

Avant de rendre un écran :
1. "Est-ce qu'on peut deviner que c'est généré par IA en 2 secondes ?"
   Si oui, identifie l'indice et supprime-le.
2. Test du logo masqué : "Logo caché, cet écran pourrait-il appartenir à
   n'importe quelle app du genre ?" Si oui, il manque l'élément signature
   du DA brief — le slop n'est pas que l'excès, c'est aussi la moyenne.

Le but n'est pas la sobriété pour la sobriété — c'est que chaque choix visuel
soit une décision, pas un réflexe statistique.

## Règles ajoutées par /retro

<!-- Les amendements validés par Baptiste s'ajoutent ici, datés -->
