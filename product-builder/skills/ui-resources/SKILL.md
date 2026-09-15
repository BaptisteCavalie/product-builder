---
name: ui-resources
description: Catalogue routé des ressources UI externes (design systems réels, tokens, composants, motion, micro-détails, grilles d'audit). Déclencher dès qu'un choix UI structurant se pose — /da, base de composants, échelle typo, vocabulaire de motion, densité, pattern complexe — pour sourcer des pistes au lieu d'inventer. Ne remplace ni le contrat de tokens, ni le DA brief, ni anti-slop.
---

# Ressources UI — la matière première des pistes

Le kit ne définit plus de bonnes pratiques par secteur. Il **source** et il
**propose** : sur un choix structurant, il ouvre les ressources ci-dessous,
en tire 2-3 pistes comparables, et Baptiste tranche. Ce qui reste écrit en dur
dans le kit, c'est le noyau régulé d'un domaine (`domain-knowledge`) et le goût
validé (`design-system/references/`) — pas des conventions UI recopiées à la main.

## La règle de subordination

Les ressources fournissent la **matière** (structures, échelles, mécaniques,
vocabulaire) ; elles ne décident jamais de la **forme**. Dans cet ordre, non
négociable :

1. le contrat de tokens du kit et le `@theme` du projet — aucune valeur ne rentre
   hors token ;
2. le DA brief du projet (`design/da.md`) — ambiance, typo nommée, signature ;
3. `anti-slop`, `a11y`, `design-judgment` — les interdits et le plancher ;
4. **ensuite** ce que la ressource propose.

Une ressource copiée telle quelle importe le goût de quelqu'un d'autre. C'est
exactement le look par défaut que ce kit existe pour empêcher : la plupart de
ces sites servent la planète entière, et leur sortie brute est la moyenne
statistique. On y prend ce qui est **structurel**, on y laisse ce qui est
**esthétique**.

## Ce qu'est un choix structurant

**Choix structurant** = un choix qui contraint les écrans suivants (base de
composants, échelle typo, vocabulaire de motion, densité, convention
sectorielle). Il se présente en 2-3 **pistes sourcées**, avec une
recommandation ; Baptiste tranche. Un choix local et réversible (un radius, une
copie, un espacement) se tranche seul — les tokens et les skills décident.

Si un principe du kit tranche déjà (a11y, contrat de tokens, un interdit
anti-slop), **il n'y a pas de piste**. Présenter comme ouvert un choix déjà
fermé par la doctrine, c'est faire perdre du temps à l'arbitrage.

## La source interrogeable — Inspo (MCP)

Les 15 ressources du catalogue sont des sites à ouvrir. **Inspo est un serveur
MCP** : il s'interroge depuis la session, sans navigateur, et renvoie des sites
réellement shippés avec leur palette, leurs polices réelles, leur rampe typo et
leurs captures desktop + mobile. C'est la différence qui compte — une référence
qu'on peut chercher, comparer et regarder en trois appels bat une galerie qu'il
faut parcourir à la main.

Archive : 832 sites de production, 2 320 pages capturées, 15 outils
(`inspo-mcp` 0.1.16, MIT, `github.com/Nutlope/inspo`).

**Les outils qui servent ici** :
- `recommend(brief, …)` — le point d'entrée : macrostructure proposée, shortlist,
  5 exemplaires, composants de référence, suggestion de palette. Une piste s'en
  nourrit, elle ne s'y résume pas.
- `search_screens(query, style?, industry?, vibe?, color?, device?)` — la
  recherche fine. `get_filters()` (zéro argument) liste les valeurs acceptées :
  l'appeler d'abord évite trois appels à deviner les enums.
- `get_design_system(slug)` — polices réelles, palette + variables CSS, rampe
  typo, tech détectée. La matière la plus directe pour sourcer une piste
  d'échelle typo ou de palette.
- `compare(slugs[])` — 2 à 4 sites côte à côte. Fait pour l'arbitrage : deux
  pistes se présentent mieux avec leurs exemplaires comparés.
- `find_by_color(hex)` · `find_similar(slug)` · `find_examples_for_macrostructure(name)`
  — les voisinages, quand une direction est déjà posée.
- `find_reference_components(type?)` + `get_reference_jsx(type, id)` — le source
  JSX d'un composant canonique. Pour la mécanique, jamais pour le style.

**Ce qu'on vole** : des sites shippés, pas des concepts. La palette tracée à la
source, la police nommée, la rampe, la macrostructure, et le couple desktop +
mobile — c'est lui qui apprend la responsivité plutôt que le seul rendu large.

**Ce qu'on laisse** :
- Le `recommend()` pris pour une direction. Il produit un moodboard ; la
  direction, c'est le DA brief, et elle se tranche à l'arbitrage.
- Les guidances intégrées (`heroGuidance`, `spacingGuidance`) livrées avec chaque
  `recommend()` : elles sont saines — un héros qui tient dans le premier
  viewport, des respirations de 80-160px entre sections — mais elles arrivent en
  pixels. Chez nous elles passent par les tokens d'espacement, jamais en valeur
  inline. Le contrat de tokens reste devant.
- La palette telle quelle : elle se reconstruit sur UNE rampe OKLCH (skill
  `color`).

**Installation** (hébergé, gratuit, sans authentification) :
`claude mcp add --transport http inspo https://inspomcp.dev/api/mcp`.
Le serveur doit être enregistré sous le nom **`inspo`** — c'est ce nom qui donne
les outils `mcp__inspo__*` déclarés par le `design-critic`.

**S'il est absent de la session** : même règle que Mobbin — le dire à
l'arbitrage comme limitation, descendre le repli (Mobbin → bibliothèque
d'exemplaires → galeries web), et ne jamais citer un écran qu'on n'a pas vu.

## Routage par intention

| Le choix porte sur | Ouvrir |
|---|---|
| Référence réelle, ambiance, palette d'un site shippé | **Inspo (MCP)** — `recommend`, `search_screens`, `get_design_system` |
| Tokens, échelles, nomenclature | designsystems.one · open-props.style · Inspo `get_design_system` |
| Typo & espacement fluides | utopia.fyi |
| Structure et états d'un composant | component.gallery · coss.com/ui · Inspo `get_reference_jsx` |
| Pattern complexe (data grid, kanban, gantt, filtres, calendrier) | reui.io/components |
| Vocabulaire de motion | kinetics.colorion.co · motion-primitives.com |
| Contenu attendu d'une section type | vibeprompts.dev |
| Finition, micro-détails d'interaction | interfaces.rauno.me |
| Audit d'un écran, sortie du look générique | ui-skills.com · designsystemchecklist.com |
| Geste signature (fond, icône, interaction) | bg.ibelick.com · iconcreator.dev · animatedbuttons.colorion.co |

## Le catalogue

Chaque entrée : ce qu'elle est, **ce qu'on vole**, **ce qu'on laisse**. Le
« ce qu'on laisse » est la partie utile — c'est lui qui empêche la ressource
de manger la direction.

### Design systems réels & composants

- **component.gallery** — 2 600+ exemples issus de 95 design systems de
  production.
  *On vole* : la comparaison. Voir comment dix systèmes nomment et découpent le
  même composant, et surtout où ils divergent — une divergence forte dit que le
  contexte décide, pas la convention.
  *On laisse* : la moyenne des dix. Faire la synthèse de tout le monde est la
  définition du slop.

- **designsystems.one** — 88 design systems de production avec tokens, stacks et
  fichiers `design.md` téléchargeables.
  *On vole* : les échelles et la nomenclature de tokens, la façon dont un système
  mature découpe ses catégories.
  *On laisse* : importer un `design.md` dans le projet. Le contrat de tokens du
  kit reste la seule structure ; un second système en parallèle, c'est deux
  sources de vérité.

- **coss.com/ui** — le design system de production de Cal.com, composants React
  accessibles qu'on possède (pas une dépendance opaque).
  *On vole* : la structure des composants, la couverture des états, les décisions
  d'accessibilité déjà tranchées par une équipe qui shippe.
  *On laisse* : la palette, la typo, les radii. Repris tels quels, le produit
  ressemble à Cal.com ; les valeurs viennent du `@theme` du projet.

- **reui.io/components** — 1 000+ composants shadcn et patterns avancés : data
  grids, kanban, gantt, filtres, calendriers.
  *On vole* : la mécanique des patterns complexes — ce qu'une data grid doit
  réellement gérer (tri, sélection multiple, densité, colonnes figées, état vide,
  chargement partiel). C'est la ressource à ouvrir avant de réinventer un tableau.
  *On laisse* : le style shadcn par défaut. C'est le look générique que
  `anti-slop` interdit nommément.

### Tokens, échelles, fondations

- **open-props.style** — tokens prêts à l'emploi : couleurs, ombres, radii,
  espacements, easings.
  *On vole* : les catégories et les pas d'échelle, en particulier les **ombres**
  et les **easings** — les deux plus durs à inventer de zéro et les deux où un
  pas mal calibré se voit immédiatement.
  *On laisse* : la palette. La couleur se construit sur UNE rampe OKLCH à
  température assumée (skill `color`), jamais sur un pack générique.

- **utopia.fyi** — typographie et espacement fluides générés (`clamp()`) entre
  deux bornes de viewport.
  *On vole* : l'échelle calculée min/max au lieu de tailles arbitraires posées
  par breakpoint.
  *On laisse* : la sortie brute collée dans le markup. Elle se range dans le
  `@theme` du projet comme n'importe quelle autre valeur.

- **designsystemchecklist.com** — checklist pratique de ce qu'un design system
  doit couvrir.
  *On vole* : le diagnostic des trous — ce que le `@theme` ne couvre pas encore,
  les états manquants, la doc absente.
  *On laisse* : la cocher intégralement. La proportionnalité prime : un projet
  n'a pas besoin d'un design system complet pour shipper une feature.

### Motion

- **kinetics.colorion.co** — animations spring prêtes (CSS, React, prompts).
  *On vole* : les valeurs de spring et de durée comme point de départ d'un
  vocabulaire de motion cohérent.
  *On laisse* : les coller dans le code. Elles se traduisent en tokens
  `--duration-*` / `--ease-*` — doctrine motion du kit, aucune durée hors token.

- **motion-primitives.com** — composants de motion React réutilisables.
  *On vole* : le découpage en primitives — ce qui s'anime, dans quel ordre, ce
  qui reste fixe pendant qu'autre chose bouge.
  *On laisse* : la dépendance. On prend l'idée, pas le paquet, sauf décision
  explicite (coût technique, hiérarchie de la constitution).

### Finition & geste signature

- **interfaces.rauno.me** — checklist des micro-détails qui font qu'une interface
  paraît finie.
  *On vole* : la passe de finition juste avant les captures — focus, sélection,
  comportement du scroll, états de transition.
  *On laisse* : en faire un bloqueur de ship. C'est majoritairement du `nit` :
  on corrige au passage, on ne relance pas une boucle pour ça.

- **bg.ibelick.com** — fonds copier-coller Tailwind/CSS.
  *On vole* : une technique de fond (grille, dégradé radial, bruit) quand elle
  peut porter l'élément signature du DA brief.
  *On laisse* : le fond décoratif sans intention. `anti-slop` interdit l'ornement
  gratuit — un fond qui ne sert pas la hiérarchie est du bruit.

- **animatedbuttons.colorion.co** — 99 interactions de bouton en CSS pur.
  *On vole* : UNE interaction, réutilisée partout. L'identité vient de la
  répétition d'un petit nombre de partis-pris.
  *On laisse* : les 98 autres. Deux styles de bouton = deux significations, pas
  deux humeurs.

- **iconcreator.dev** — éditeur d'icônes custom dans le navigateur.
  *On vole* : l'icône que personne n'a — celle que le produit a besoin de nommer
  et qu'aucune librairie ne dessine.
  *On laisse* : refaire un jeu complet à la main. Cohérence de grille et de
  graisse avant originalité.

### Cadrage & audit

- **ui-skills.com** — playbooks de design pour humains et agents de code : audit
  d'UI, sortie du design générique produit par IA, motion, accessibilité, polish.
  *On vole* : les grilles d'audit, pour confronter la rubrique du kit à un regard
  extérieur avant une critique importante.
  *On laisse* : substituer un playbook à la rubrique du `design-critic`. La
  rubrique du kit reste la référence ; un playbook externe l'enrichit, il ne la
  remplace pas.

- **vibeprompts.dev** — 256 prompts par section d'UI : dashboards, pricing, auth,
  onboarding, hero.
  *On vole* : la cible de layout concrète — ce qu'une page de pricing ou un
  onboarding contient réellement, section par section. Utile comme checklist de
  contenu avant de dessiner.
  *On laisse* : le prompt tel quel. Un prompt générique produit un écran
  générique ; il décrit quoi mettre, jamais à quoi ça ressemble.

## Le format d'une piste

```
**Piste A — <nom court>**
- Ce que ça donne : <une phrase concrète, ce qui change à l'écran>
- Source : <ressource ouverte> — <ce qu'on en tire exactement>
- Coût : <ce que ça engage : dépendance, temps, contrainte sur les écrans suivants>
- Ce que ça ferme : <l'option que ça rend difficile ensuite>
```

Puis, toujours : **Recommandation : <A|B|C>, parce que <principe ou référence>.**

Un menu neutre n'est pas un livrable senior. Tu as un avis, tu le dis, et
Baptiste garde la main pour le contredire.

## Règles

- **2 ou 3 pistes.** Deux pistes qui se ressemblent n'en font qu'une. Jamais
  quatre — au-delà, ce n'est plus un arbitrage, c'est un catalogue.
- **Chaque piste est sourcée** : au moins une ressource réellement ouverte.
  Jamais une piste inventée puis habillée d'une URL après coup.
- **Jamais de ressource citée sans l'avoir consultée.** Même règle que pour
  Mobbin dans /da : une référence qu'on n'a pas vue n'existe pas.
- **Ressource injoignable** (site mort, politique réseau de la session, 403) :
  le dire explicitement dans la salve d'arbitrage, descendre le repli — autre
  ressource de la même ligne du routage → Mobbin → bibliothèque d'exemplaires du
  kit — et ne jamais faire semblant. Une piste dont la source n'a pas pu être
  ouverte se présente comme telle.
- Le catalogue dit ce qu'on retient de chaque ressource ; il **ne dispense pas**
  d'ouvrir la page au moment du choix.

## Statut du catalogue

Les 15 entrées web viennent de la sélection de Baptiste (13/09/2026) ; leurs
URLs n'ont pas pu être ouvertes depuis la session d'écriture (accès réseau
refusé par la politique d'egress). Une ressource morte ou dérivée **se retire du
catalogue** — elle ne se contourne pas en devinant ce qu'elle contenait.

Inspo, lui, est vérifié : paquet `inspo-mcp` 0.1.16 lu sur le registre npm le
15/09/2026 (MIT, `github.com/Nutlope/inspo`, 15 outils). Son endpoint hébergé
n'était pas joignable depuis cette session — l'installation est donc à faire et
à tester côté Baptiste.
Le catalogue s'amende comme le reste du kit : via `/retro`.
