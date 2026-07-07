---
name: anti-slop
description: Liste des interdits à vérifier sur TOUT output avant de le considérer terminé — visuel (composants, pages, emails, slides, SVG) ET texte long-forme (articles, READMEs, posts, docs). Déclencher systématiquement en phase de build ET de critique, sur toute génération sans exception.
---

# Anti-slop

Le slop naît de l'absence de contraintes. Ce fichier EST la contrainte (le
plancher : ce qu'on ne fait jamais). Le plafond — ce qu'on fait bien — vit
dans `art-direction` et `color`. Chaque interdit est vérifiable en oui/non. Ce
fichier s'enrichit via /retro : chaque correction de goût de Baptiste devient
une règle ici.

## Comment utiliser cette liste

Cette liste se PARCOURT ligne à ligne sur le rendu ET le CSS/markup — au build
(avant de déclarer fini) ET en critique. On coche CHAQUE interdit, un par un.
Un jugement global « ça respecte anti-slop » n'est PAS une vérification : sans
énumération interdit par interdit, le verdict est invalide.

**Chaque interdit a un ID stable (`AS-…`) — cite-le.** Dans les verdicts
critics (champ `principle`) et la télémétrie (`regles_anti_slop` de
`runs.jsonl`), on référence l'ID, pas une paraphrase. C'est ce qui rend
l'élagage de /retro mesurable : une règle dont l'ID n'apparaît jamais sur de
nombreux runs est candidate au retrait ; sans ID, « jamais déclenchée » est
invérifiable.

Les interdits marqués **⚙** sont aussi attrapés en continu par la gate
déterministe `scripts/check-slop.sh` (hook PostToolUse) : la passe énumérée
reste — la gate rattrape l'oubli, elle ne remplace pas l'œil.

**Interdits qui passent le plus souvent à travers les mailles** (vérifier en
premier, sur le CSS autant que sur le rendu) :
- ❌ **Bordure d'accent à gauche** d'une card/callout (`border-left` coloré)
  — c'est `AS-C04`.
- ❌ **Card-in-card** : un coin arrondi à l'intérieur d'un coin arrondi — un
  conteneur déjà délimité (card, panel, `<details>`, modale, accordéon) ne
  contient jamais d'enfant avec sa propre bordure + radius — c'est `AS-CP04`.

## Interdits absolus

**Couleur**
- ❌ `AS-C01` ⚙ Toute valeur hors tokens (`#FACC15`, `bg-yellow-400` hors
  système, durée ms en dur…).
- ❌ `AS-C02` ⚙ Gradients décoratifs (sur CTA, titres, fonds de cards, bordures).
- ❌ `AS-C03` L'accent violet/lavande en couleur "AI product" par défaut (famille
  #7c6af7…) — en glow sur fond sombre comme en gradient pastel sur fond clair.
  Accent délibéré et non-violet sauf justification écrite du DA brief.
- ❌ `AS-C04` ⚙ Bordures colorées d'accent à gauche des cards/callouts.
- ❌ `AS-C05` Une couleur différente par item de liste/catégorie "pour faire vivant".
- ❌ `AS-C06` Accent utilisé en décoration (fonds, icônes passives) plutôt qu'en signal.

**Typographie**
- ❌ `AS-T01` Plus de 2 graisses par écran.
- ❌ `AS-T02` Alternance de graisses dans une même phrase pour "dynamiser".
- ❌ `AS-T03` Mots isolés en couleur d'accent au milieu d'un titre.
- ❌ `AS-T04` Tout en capitales sur plus de 3 mots (hors micro-labels avec letter-spacing).
- ❌ `AS-T05` Tailles de police hors échelle des tokens.

**Composition**
- ❌ `AS-CP01` Ombres portées sur les cards de contenu statique — l'élévation est
  réservée aux éléments flottants (modale, dropdown, toast).
- ❌ `AS-CP02` Border + ombre + fond teinté cumulés sur un même conteneur (choisir
  UN séparateur, ou juste l'espace).
- ❌ `AS-CP03` Coins arrondis incohérents (un seul radius de tokens par famille de composants).
- ❌ `AS-CP04` Conteneurs encadrés imbriqués — pas seulement les "cards" : un parent
  déjà délimité (card, `.panel`, `<details>`/disclosure, modale, accordéon) ne
  contient JAMAIS d'enfants avec leur propre bordure + radius. Les enfants sont
  à plat ; pour différencier, on change le FOND (surface recessed), jamais on
  ajoute une 2e bordure. Test : aucun coin arrondi à l'intérieur d'un coin arrondi.
- ❌ `AS-CP05` La grille de 3 cards "features" avec icône centrée + titre + paragraphe,
  par réflexe — ce pattern doit être justifié, pas défaut.

**Iconographie & ornement**
- ❌ `AS-IC01` Emojis comme icônes ou puces dans l'UI produit.
- ❌ `AS-IC02` Icône devant CHAQUE titre, item de menu ou cellule — l'icône doit
  ajouter du sens, sinon rien.
- ❌ `AS-IC03` Illustrations 3D génériques type "blob people" / memphis / isométrique stock.
- ❌ `AS-IC04` ⚙ Sparkles ✨ et toute imagerie "magie IA".

**Copy** (le plafond — le mot juste — vit dans `ux-writing` ; ici le plancher)
- ❌ `AS-CY01` "Supercharge", "Unleash", "Seamless", "Effortless", "Élevez votre…",
  "Boostez", "révolutionnaire" et tout superlatif vide.
- ❌ `AS-CY02` Point d'exclamation dans l'UI (réservé aux vraies célébrations, max 1).
- ❌ `AS-CY03` Tirets cadratins en cascade et tournures "It's not just X, it's Y".
- ❌ `AS-CY04` Bouton générique qui décrit le mécanisme : "Soumettre", "Submit", "OK",
  "Valider" seul — le label dit l'action ("Créer mon compte", "Supprimer").
- ❌ `AS-CY05` ⚙ Erreur qui ne dit pas quoi faire : "Oops! Something went wrong", "Une
  erreur est survenue", code brut exposé — toujours cause claire + issue.
- ❌ `AS-CY06` ⚙ Empty state qui constate au lieu de guider : "Aucune donnée", "Rien à
  afficher" — sans l'action pour le remplir.
- ❌ `AS-CY07` Placeholder utilisé comme seul label (disparaît à la saisie).
- ❌ `AS-CY08` Title Case anglais sur un titre FR, "Editer" et autres calques de l'anglais.
- ❌ `AS-CY09` ⚙ Lorem ipsum ou texte de remplissage shippé tel quel.

**Prose long-forme** (articles, READMEs, posts, docs — le plancher de la
rédaction ; le plafond reste `ux-writing`). Ces tournures trahissent le texte
généré : aucune n'est interdite à l'unité, c'est le RÉFLEXE systématique qui est
le tell. Mesurées par fréquence sur le corpus de Baptiste (colonne « articles
touchés ») — vérifier d'abord celles qui contaminent le plus d'articles.
- ❌ `AS-PR01` **Deux-points explicatifs** en cascade pour poser puis « révéler » (« La clé : … »).
- ❌ `AS-PR02` **Sous-titres H2/H3 systématiques** découpant un texte court qui n'en a pas besoin.
- ❌ `AS-PR03` Formules **« de X à Y »** pour balayer un faux spectre (« de la stratégie à l'exécution »).
- ❌ `AS-PR04` **Tricolons** réflexes — l'énumération à trois termes « X, Y et Z » par cadence, pas par sens.
- ❌ `AS-PR05` Jargon **« agentique » / « agents »** plaqué là où un mot concret suffit.
- ❌ `AS-PR06` **« vrai/vraie » + nom** pour fabriquer de l'enjeu (« le vrai problème », « la vraie question »).
- ❌ `AS-PR07` **« signal »** en tic (« c'est un signal que… »).
- ❌ `AS-PR08` **Questions rhétoriques** qui s'auto-répondent (« Pourquoi ça marche ? Parce que… »).
- ❌ `AS-PR09` **Guillemets typographiques** en scare-quotes sur des mots ordinaires pour faire entendu.
- ❌ `AS-PR10` **Tirets longs** (—) en ponctuation d'emphase à répétition (cf. « Copy » pour l'UI).
- ❌ `AS-PR11` Structure **« pas X, mais Y »** et sa variante **« ce n'est pas…, c'est… »**, contraste fabriqué.
- ❌ `AS-PR12` **« selon »** vague sans source réelle (« selon les experts »).
- ❌ `AS-PR13` **Appel direct au lecteur** réflexe (« vous l'aurez compris », « imaginez que… »).
- ❌ `AS-PR14` **« il faut »** impersonnel et injonctif à répétition.
- ❌ `AS-PR15` **Puces** par défaut là où une phrase suffit — la liste découpe une vraie énumération, pas un paragraphe.
- ❌ `AS-PR16` **Gras markdown** semé pour « guider l'œil » — l'emphase partout = emphase nulle part.
- ❌ `AS-PR17` **« promesse »** en tic de pitch (« la promesse de… »).

**Layout**
- ❌ `AS-LY01` Hero centré + badge pilule "New ✨" + titre 3 lignes + 2 CTA côte à côte,
  par défaut — encore une fois : possible si justifié, interdit par réflexe.
- ❌ `AS-LY02` Sections alternées image-gauche/image-droite sur toute une landing.

**Défauts statistiques**
- ❌ `AS-DS01` Le look "Tailwind par défaut" shippé tel quel : police système/Inter +
  fond gray-50 + cards blanches + shadow-sm + rounded-xl + accent bleu.
  Chaque élément est légal isolément ; l'ensemble par réflexe, sans DA brief
  qui le justifie, est le slop le plus répandu — la propreté n'excuse pas
  l'absence de direction.
- ❌ `AS-DS02` Typographie subie "parce qu'elle est là" — la police du projet est NOMMÉE
  dans `design/da.md`, choisie pour l'ambiance, jamais par défaut.
- ❌ `AS-DS03` Construire de l'UI sans DA brief (`design/da.md`) : sans direction
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

<!-- Les amendements validés par Baptiste s'ajoutent ici, datés, avec le
     prochain ID AS-R libre -->

**2026-06-13 — `AS-R01` Combo "AI-app générique" bannie.** Le défaut statistique
2024-25 de l'app IA : fond en gradient pastel/lavande + glassmorphism (surfaces
backdrop-blur) + grosses orbs floues en radial-gradient + accent violet/lavande
(famille #7c6af7). Chaque trait peut être légal isolément ; l'ensemble par
réflexe = absence de parti-pris (le pendant "AI" du look Tailwind par défaut).
Défaut imposé à la place : surfaces plates + filets 1px + un accent délibéré,
non-violet. (L'accent seul est aussi couvert ligne à ligne : `AS-C03`.)
