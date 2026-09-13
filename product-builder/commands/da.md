---
description: Direction artistique du projet — recherche de références multi-sources, pistes sourcées sur les choix structurants, arbitrage de Baptiste, puis rédaction de design/da.md
argument-hint: [description du produit, ou vide si le CLAUDE.md du projet suffit]
---

# /da — Direction artistique

Produit : $ARGUMENTS (sinon, lis le CLAUDE.md du projet — domaine, utilisateurs, contexte).

Le DA brief est ce qui sépare un build "propre" d'un build qui a du caractère.
Sans lui, le build retombe sur la moyenne statistique — le look par défaut,
interdit par anti-slop. Il se rédige UNE fois par projet, s'amende via /retro,
et le `@theme` de l'entrypoint CSS en dérive.

C'est aussi le **seul checkpoint humain** du pipeline : tous les choix qui
contraignent les écrans suivants se tranchent ICI, en une salve, pas au fil de
l'eau pendant le build.

Si `design/da.md` existe déjà : mode révision — relis-le, confronte-le à la
demande, propose des amendements ciblés. Ne repars pas de zéro.

## 1. Cerner le territoire

Avant toute recherche, pose le cadre en 3 lignes :
- Qui utilise ce produit, dans quel état d'esprit (pressé ? méfiant ? passionné ?).
- Les 2-3 gestes utilisateurs prioritaires que les écrans doivent servir
  (les actions répétées qui justifient l'outil) — la DA se juge sur eux, et
  la salve d'arbitrage (étape 4) montre comment chaque piste les sert.
- Quelle est la culture visuelle du domaine — une app de pronos ne ressemble
  pas à une app d'épargne. Charge `domain-knowledge` si une référence existe :
  elle ne donne plus de conventions UI, mais les **contraintes** que le métier
  impose aux pistes (régulé, données sensibles, vocabulaire).
- 3 mots d'ambiance candidats + 3 anti-mots (ce que l'écran ne doit JAMAIS dégager).

Ces réponses viennent du brief et du CLAUDE.md du projet (Domaine /
Utilisateurs / Spécificités). Si une info manque, NE DEVINE PAS : pose les
questions manquantes à Baptiste en une seule salve (4 max, fermées autant que
possible), écris les réponses dans le CLAUDE.md du projet, puis continue.
Un territoire deviné = une DA générique — exactement ce que ce pipeline
existe pour empêcher.

## 2. Collecter des références — dans cet ordre

> Si une source MCP attendue (Mobbin) est indisponible dans la session
> (serveur non monté), NE PAS faire semblant : signale-le explicitement dans le
> rapport comme limitation, descends la chaîne de repli (exemplaires kit →
> galeries web), et capture les références web retenues (point 4).

1. **Bibliothèque d'exemplaires du kit** (`design-system/references/` du plugin,
   chemin injecté en début de session) : le goût de Baptiste, consultée EN
   PREMIER. Chaque exemplaire a un statut (cf. README) : **validé** (approuvé à
   l'œil / via /retro) ou **proposé** (sourcé, pas encore validé). Si tu pars
   d'un « proposé », tu peux — mais signale-le à l'arbitrage (étape 4) : la DA
   s'ancre alors sur un candidat, pas sur du goût gravé. Si un exemplaire couvre
   le territoire, pars de lui.
   Si elle est VIDE (aucun `.png`, juste le README) ou qu'aucun exemplaire ne
   couvre le territoire, NE DÉGRADE PAS EN SILENCE vers Mobbin/web : c'est une
   limitation de premier ordre — même statut qu'une source MCP indisponible — à
   signaler explicitement à l'arbitrage (étape 4). Sans exemplaire, la DA ne
   s'ancre sur aucun goût validé du kit ; la porter à Baptiste à CHAQUE /da est
   précisément ce qui finit par remplir la bibliothèque (via /retro).
2. **Mobbin (MCP)** — produits réels shippés. Cherche des comparables du domaine
   ET 1-2 apps hors domaine réputées pour leur craft. REGARDE les images
   retournées (elles arrivent inline) : c'est l'image qui porte la leçon, pas
   les métadonnées. Note la requête et le `mobbin_url` de chaque écran retenu —
   le design-critic ré-interrogera le MCP avec.
3. **Galeries web** (WebSearch + WebFetch) — pour l'ambiance, la typo, la couleur :
   - **Awwwards / Godly / SiteInspire** : sites à forte direction artistique.
     À piller pour la typo, la palette, l'attitude — surtout landing et
     marketing. Attention : l'esthétique "site de l'année" ne se transpose pas
     telle quelle à une UI produit utilisée tous les jours.
   - **Dribbble** : exploration visuelle pure. La plupart des shots sont des
     concepts jamais shippés : voler l'ambiance, la palette, les appariements
     typographiques — JAMAIS les mécaniques de layout ni les patterns de
     composants (ça, c'est le rôle de Mobbin et de la pattern library).
   - **Fonts In Use** : typographies réelles classées par secteur — la source
     pour NOMMER la police au lieu de subir celle par défaut.
   - **Hors-UI — l'adjacent** : éditorial print & magazines (Eye, It's Nice
     That), affiche & identité (Brand New), photographie, type specimens des
     fonderies. Les galeries ci-dessus sont incestueuses : tout le monde y
     regarde les mêmes shots → on converge vers le trend = slop. **Un geste
     signature fort se vole HORS de la discipline** (une grille de magazine, un
     cadrage photo, un specimen) puis se traduit en UI. Au moins une référence
     hors-UI dès qu'on vise le haut du curseur d'audace (étape 3).
4. **Catalogue de ressources UI** (skill `ui-resources`) — pas pour l'ambiance,
   pour la **structure** : échelles de tokens, mécaniques de composants,
   vocabulaire de motion, contenu attendu d'une section. C'est la matière
   première des pistes de l'étape 3. Le skill route par intention et dit, pour
   chaque ressource, ce qu'on vole et ce qu'on laisse.
5. Pour chaque référence d'ambiance retenue, sauvegarde une **capture image**
   dans `design/references/` — c'est la norme, pas l'option :
   - source web publique → le script de capture du kit (chemin injecté en début
     de session) : `<chemin>/capture-ref.sh <url> design/references/<source>-<app>.png`
     (Playwright headless, viewport 1440×900 : rend la vraie page, là où `curl`
     d'og:image échoue souvent / renvoie un logo générique). En cas d'échec, il
     le signale et bascule sur le repli ci-dessous.
   - app authentifiée (Linear, etc.) ou capture impossible → en DERNIER recours,
     URL + requête exacte, et le signaler comme limite dans le rapport.
   - **Résolution** : une page publique se capture en haute-déf
     (`capture-ref.sh`, 1440×900) — préfère-la. Une preview Mobbin (~300px iOS /
     ~768px web) ancre un registre/pattern mais pas le micro-craft (filet 1px,
     calage typo) : utilisable, mais note-le et ne juge pas la précision dessus.

**3 références d'ambiance retenues MAX.** Dix moodboards = zéro direction.

## 3. Préparer les pistes sur les choix structurants

Charge les skills `art-direction` (typo nommée + appariement, composition,
motion, retenue senior), `color` (température des neutres, teinte d'accent,
harmonie) et `ui-resources` (le catalogue) — pas tes réflexes génériques.

**Choix structurant** = un choix qui contraint les écrans suivants (base de
composants, échelle typo, vocabulaire de motion, densité, convention
sectorielle). Il se présente en 2-3 **pistes sourcées**, avec une
recommandation ; Baptiste tranche. Un choix local et réversible (un radius, une
copie, un espacement) se tranche seul — les tokens et les skills décident.

Liste les choix structurants de CE projet (**5 maximum** dans la salve : au-delà,
tu n'as pas fait le tri), et pour chacun rédige 2-3 pistes au format du skill
`ui-resources` : ce que ça donne à l'écran, la source ouverte, le coût, ce que
ça ferme, puis ta recommandation motivée.

Si un principe du kit tranche déjà le choix (a11y, contrat de tokens, un
interdit anti-slop, une contrainte du domaine), **il n'y a pas de piste** :
tranche seul et n'encombre pas l'arbitrage.

**Le curseur d'audace est le premier choix structurant** — showcase/bold ↔
produit/sobre. Ce n'est pas réglé par les références (c'est une *décision*, pas
un exemple) : un même domaine se traite sobre ou tranché selon qui l'utilise et
dans quel état d'esprit (étape 1). Présente-le calibré sur les trois bornes de
la bibliothèque d'exemplaires (`design-system/references/`) : **BNP** (basse —
rassurer par la convention), **Qonto** (milieu — retenue habitée), **Revolut**
(haute — parti-pris signature « postable sur Dribbble »). Le curseur dose
l'élément signature et conditionne le sourcing (haut du curseur ⇒ au moins une
référence hors-UI, étape 2). Voir `skills/art-direction`.

Chaque piste se justifie par une référence ou un principe. "Parce que c'est
joli" n'est pas une justification ; "comme <référence>, parce que <principe>"
en est une.

## 4. L'arbitrage — le seul checkpoint

Présente à Baptiste, de façon compacte et **en une seule salve** :
- le territoire et l'ambiance candidate (3 mots + 3 anti-mots) ;
- les références d'ambiance retenues, avec liens et captures ;
- les **pistes** de l'étape 3, choix par choix, avec ta recommandation pour
  chacun.

En tête de salve, liste sans les noyer les **limitations de sourcing**
rencontrées : bibliothèque d'exemplaires vide (le goût du kit ne s'est ancré sur
rien), exemplaires seulement *proposés* (sourcés, non validés à l'œil — la DA
s'appuie sur des candidats), Mobbin indisponible, et/ou ressource du catalogue
injoignable (une piste dont la source n'a pas pu être ouverte se présente comme
telle). Une DA bâtie sans aucun exemplaire kit reste valide mais fragile — c'est
le signal, répété à chaque /da tant que la bibliothèque reste vide, qu'il faut
l'amorcer.

Baptiste tranche piste par piste. C'est LE moment où son goût ancre le projet —
tout l'aval (builds, critiques, corrections) est autonome.

## 5. Écrire LA direction

Une fois l'arbitrage rendu, commets-toi sur une direction unique. **Le brief
écrit ne contient jamais un menu** : les pistes meurent à l'arbitrage, `design/da.md`
ne porte que ce qui a été tranché, plus la raison. Remplis le format de
`design/_template.md` : territoire, ambiance/anti-mots, références (ce qu'on
vole / ce qu'on laisse), typographie nommée, couleur, densité et forme, motion,
position du curseur d'audace, l'élément signature, ce qu'on rejette.

Note en une ligne, pour chaque choix tranché, la piste retenue et les pistes
écartées — c'est ce qui évite de re-explorer les mêmes options au prochain
/retro. L'élément signature est obligatoire : c'est LE choix qui rend le produit
reconnaissable logo masqué.

## 6. Matérialiser

Dérive le `@theme` de l'entrypoint CSS du brief validé, en matérialisant le
contrat de `design-system/tokens.css` et en appliquant le skill `color` :
neutres construits sur UNE rampe OKLCH à température assumée, accent
(+ hover/subtle) au bon pas, sémantiques cohérentes avec l'accent,
`--font-sans` chargée proprement (next/font, pas de `<link>` bloquant), radii
selon la personnalité de forme. Le DA brief est la justification écrite de
chaque valeur du `@theme`.
