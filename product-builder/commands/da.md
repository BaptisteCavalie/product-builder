---
description: Direction artistique du projet — recherche de références multi-sources puis rédaction de design/da.md, le parti-pris visuel qui gouverne tous les builds
argument-hint: [description du produit, ou vide si le CLAUDE.md du projet suffit]
---

# /da — Direction artistique

Produit : $ARGUMENTS (sinon, lis le CLAUDE.md du projet — domaine, utilisateurs, contexte).

Le DA brief est ce qui sépare un build "propre" d'un build qui a du caractère.
Sans lui, le build retombe sur la moyenne statistique — le look par défaut,
interdit par anti-slop. Il se rédige UNE fois par projet, s'amende via /retro,
et le `@theme` de l'entrypoint CSS en dérive.

Si `design/da.md` existe déjà : mode révision — relis-le, confronte-le à la
demande, propose des amendements ciblés. Ne repars pas de zéro.

## 1. Cerner le territoire

Avant toute recherche, pose le cadre en 3 lignes :
- Qui utilise ce produit, dans quel état d'esprit (pressé ? méfiant ? passionné ?).
- Les 2-3 gestes utilisateurs prioritaires que les écrans doivent servir
  (les actions répétées qui justifient l'outil) — la DA se juge sur eux, et
  le brief présenté à la validation (étape 4) montre comment elle les sert.
- Quelle est la culture visuelle du domaine — une app de pronos ne ressemble
  pas à une app d'épargne. Charge `domain-knowledge` si une référence existe.
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
   chemin injecté en début de session) : le goût déjà validé par Baptiste.
   Si un exemplaire couvre le territoire, pars de lui.
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
4. Pour chaque référence retenue, sauvegarde une **capture image** dans
   `design/references/` — c'est la norme, pas l'option :
   - source web publique → `npx playwright screenshot --viewport-size=1440,900 <url> design/references/<source>-<app>.png` (rend la vraie page, là où `curl` d'og:image échoue souvent / renvoie un logo générique).
   - app authentifiée (Linear, etc.) ou capture impossible → en DERNIER recours, URL + requête exacte, et le signaler comme limite dans le rapport.

**3 références retenues MAX.** Dix moodboards = zéro direction.

## 3. Trancher UNE direction

Commets-toi sur une direction unique — pas un menu d'options. Remplis le
format de `design/_template.md` : territoire, ambiance/anti-mots, références
(ce qu'on vole / ce qu'on laisse), typographie nommée, couleur, densité et
forme, motion, l'élément signature, ce qu'on rejette.

Charge les skills `art-direction` (typo nommée + appariement, composition,
motion, retenue senior) et `color` (température des neutres, teinte d'accent,
harmonie) pour trancher — pas tes réflexes génériques.

Chaque choix se justifie par une référence ou un principe. "Parce que c'est
joli" n'est pas une justification ; "comme <référence>, parce que <principe>"
en est une. L'élément signature est obligatoire : c'est LE choix qui rend le
produit reconnaissable logo masqué.

## 4. Validation — le seul checkpoint

Présente le brief de façon compacte à Baptiste : ambiance, police nommée,
palette, élément signature, les références avec liens. C'est LE moment où son
goût ancre le projet — tout l'aval (builds, critiques, corrections) est
autonome. Intègre ses retours, puis écris `design/da.md`.

## 5. Matérialiser

Dérive le `@theme` de l'entrypoint CSS du brief validé, en matérialisant le
contrat de `design-system/tokens.css` et en appliquant le skill `color` :
neutres construits sur UNE rampe OKLCH à température assumée, accent
(+ hover/subtle) au bon pas, sémantiques cohérentes avec l'accent,
`--font-sans` chargée proprement (next/font, pas de `<link>` bloquant), radii
selon la personnalité de forme. Le DA brief est la justification écrite de
chaque valeur du `@theme`.
