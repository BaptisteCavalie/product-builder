---
name: color
description: Direction des couleurs — comment construire et matérialiser une palette (le @theme du projet) au lieu de poser des valeurs au hasard. Déclencher dès qu'on touche à la couleur : choix d'accent, neutres, états, sémantiques, dark mode, data-viz, ou remplissage du @theme. Complète design-judgment (couleur = signal) et a11y (contraste = plancher).
---

# Direction des couleurs

design-judgment dit *quand* mettre de la couleur (signal, jamais décoration) ;
a11y fixe le *plancher* de contraste. Ce skill dit *comment construire la
palette elle-même. Il s'applique au remplissage du `@theme` du projet (les
valeurs), jamais au contrat de catégories `design-system/tokens.css` — on ne
re-tranche pas la doctrine tokens, on choisit bien les valeurs des catégories
existantes.

## Le noyau (si tu ne retiens que 4 choses)

1. Construis en OKLCH une **rampe** par teinte — jamais une valeur isolée.
2. Les **neutres ne sont pas gris** : une température assumée (chaud/froid).
3. **UN** accent qui signale ; les sémantiques de la même famille.
4. Contraste **prouvé** (ratio chiffré), jamais estimé à l'œil.

## 1. Raisonne en OKLCH, pas en HEX ni HSL

OKLCH = luminance perceptuelle : à L égal, deux teintes paraissent aussi
claires (un jaune et un bleu à L=0.65 ont la même clarté perçue ; en HSL,
faux). Construire et transformer en OKLCH évite les contrastes imprévus et les
saturations qui s'effondrent. Supporté nativement par tous les navigateurs
depuis 2025 : `oklch(L C H)` peut rester la valeur finale du token, pas
seulement l'outil de calcul.

**Portée.** Vrai pour le web/app rendu en navigateur moderne. Pour un **email**
ou un vieux webview (OKLCH non supporté), garde la même rampe mais sors la
valeur finale en HEX/sRGB. Et le contrat n'expose que ~3 pas d'accent
(`accent`, `accent-hover`, `accent-subtle`) + 7 neutres : tu ne déclares pas 12
variables, tu **choisis les valeurs de ces catégories-là sur une rampe mentale
de 12 pas**.

## 2. Une couleur = une rampe, jamais une valeur isolée

Une teinte se décline en pas à rôles fixes (modèle Radix, 12 pas) :
fonds (1-2) → surfaces/sélections subtiles (3-5) → bordures/séparateurs (6-8)
→ solide/accent (9-10) → texte (11-12). Le contrat de tokens encode déjà cette
rampe pour les neutres (`bg → surface → border → border-strong →
text-muted → text-secondary → text`) : remplis-les depuis UNE rampe OKLCH, pas
sept gris choisis séparément. Un accent posé sans ses pas (hover, subtle,
solid) n'a pas d'états cohérents.

## 3. Construis la rampe à pas de luminance réguliers

Fixe la suite des L une fois (ex. ~0.98 / 0.95 / 0.91 / 0.86 / 0.79 / 0.71 /
0.63 / 0.55 / 0.49 / 0.43 / 0.32 / 0.22) et réutilise-la pour chaque teinte.
Ne baisse la chroma que pour rester dans le gamut aux extrêmes. Un ajustement
de L ne doit jamais tuer la saturation (Refactoring UI).

## 4. Les neutres ne sont pas gris

Un gris de chroma 0 est mort. Donne aux neutres une légère chroma
(≈ 0.004–0.02) vers une teinte assumée — chaude (papier, terre) ou froide
(ardoise, encre) — alignée sur l'ambiance du DA brief. La température des
neutres porte l'essentiel du ressenti d'un écran ; c'est un choix, pas un
défaut. Froid = clinique/tech, chaud = humain/éditorial.

## 5. UN accent, choisi pour signaler

Une seule teinte d'accent par produit (les sémantiques ne comptent pas).
Choix par contraste de teinte avec les neutres et cohérence d'ambiance — pas
par mode. Accent au pas 9-10 ; `accent-hover` = un pas plus foncé (ou −0.04 L,
même H/C) ; `accent-subtle` = pas 3 (fond de sélection, jamais décoratif).

## 6. Les sémantiques sont membres du système

positive / negative / warning partagent la logique de rampe et un niveau de
chroma proche de l'accent, pour appartenir à la même famille — jamais un rouge
ou un vert criard importé d'une autre palette. Elles ne servent qu'à signaler
un état, jamais à décorer.

## 7. Contraste : prouve-le, vise APCA

AA (4.5:1 texte courant, 3:1 grand texte / UI) est le plancher a11y. Mais
raisonne en L OKLCH pour prédire le contraste sans tâtonner, et préfère APCA
(Lc, le modèle de contraste de WCAG 3 / Radix) qui modélise mieux la
perception réelle, surtout texte sur fond coloré. Jamais "à l'œil" : un ratio
chiffré, toujours.

## 8. Dark mode n'est pas une inversion

Inverser la rampe casse tout (accents fluo, ombres invisibles). Construis une
rampe sombre dédiée : fonds non-noirs (L ≈ 0.15–0.22, légère chroma), accent à
chroma réduite et L remontée pour rester lisible, élévation par surface plus
claire (pas par ombre). Vérifie le contraste séparément en sombre.

## 9. Harmonie : analogues ou complémentaire, jamais l'arc-en-ciel

S'il faut une 2e teinte (rare) : analogue (±30° de H) = calme/cohésion ;
complémentaire (≈180°) = tension, à réserver à un CTA. Au-delà de 2 teintes +
sémantiques, c'est du slop "pour faire vivant" (cf. anti-slop). Data-viz : une
rampe séquentielle d'une seule teinte (par L) bat dix couleurs catégorielles.

## 10. Proportion 60 / 30 / 10

≈ 60% neutre dominant (fonds), ≈ 30% neutre secondaire (surfaces, texte),
≈ 10% accent. Si l'accent occupe plus de ~10% de la surface, ce n'est plus un
signal, c'est une ambiance — et probablement du slop.
