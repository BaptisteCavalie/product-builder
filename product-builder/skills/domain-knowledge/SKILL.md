---
name: domain-knowledge
description: Noyau régulé d'un domaine produit (fintech, santé, paris sportifs, e-commerce…) — réglementation, données sensibles, vocabulaire métier, erreurs critiques. Déclencher au début de TOUT build ou critique pour charger la référence du domaine déclaré dans le CLAUDE.md du projet : un formulaire dans une app bancaire ou médicale n'est pas un formulaire générique. Déclencher aussi quand le brief mentionne un secteur, une réglementation, ou un type d'utilisateur métier.
---

# Domain Knowledge — routeur

Ce skill ne contient pas de connaissance lui-même : il route vers la bonne
référence métier. Les références vivent dans `references/`.

## Ce qu'une référence métier contient — et ne contient plus

Elle porte **uniquement ce qu'aucune ressource UI ne donnera jamais** :
réglementation et contraintes légales, données sensibles et leurs règles
d'affichage, vocabulaire et conventions propres au métier, erreurs et cas
limites critiques du domaine.

Elle ne porte **plus de conventions UI sectorielles** (« dans ce secteur on
fait des cartes plutôt que des lignes »). Les définir à la main, secteur par
secteur, c'était figer une mode dans un fichier. Ces choix se sourcent
maintenant au moment de la décision via le skill `ui-resources` et se tranchent
en **pistes** au /da — Baptiste arbitre, le kit ne présume pas.

La frontière, en une question : *est-ce que ça reste vrai si le goût de
l'époque change ?* Le message d'avertissement ANJ, le format `1 234,56 €`, le
vig d'une cote : oui, ça va dans la référence. Une densité, un style de carte,
une convention de navigation : non, c'est une piste.

## Procédure

1. Lis la section `## Domaine` du CLAUDE.md du projet.
   - Elle déclare le domaine actif (ex. `fintech`) et d'éventuelles
     spécificités (ex. "B2C, clientèle senior, réglementation AMF").
2. Charge `references/<domaine>.md` et applique ses règles pendant tout le
   build et la critique, au même titre que design-judgment.
3. Au /da, transmets sa section **« Ce que le domaine impose aux pistes »** :
   ce sont les contraintes qui cadrent les pistes, pas des solutions toutes
   faites.
4. Si la section `## Domaine` est absente : demande à Baptiste le domaine
   AVANT de construire, puis propose de l'ajouter au CLAUDE.md du projet.

## Domaine sans référence existante

Si `references/<domaine>.md` n'existe pas :
1. Le signaler explicitement ("nouveau domaine, je bootstrap le noyau régulé").
2. Lancer le `pattern-researcher` avec une mission **restreinte à 4 axes** :
   réglementation et contraintes légales, données sensibles et leur affichage,
   vocabulaire et conventions du métier, erreurs et cas limites critiques.
   Il ne cherche PAS de conventions UI — c'est le rôle des pistes au /da.
3. Rédiger la référence sur le modèle de `references/_template.md` et l'utiliser
   directement dans la session courante. NE l'écris PAS dans le kit : une
   session projet ne mute jamais le kit (ni le cache du plugin, ni un clone).
4. La faire valider par Baptiste avant le build — une référence métier fausse
   est pire que pas de référence. Chaque contrainte réglementaire porte sa
   source (texte, autorité, date) ; sans source, elle ne rentre pas.
5. Consigner la référence validée (contenu complet, cible
   `product-builder/skills/domain-knowledge/references/<domaine>.md`) comme
   amendement kit dans le rapport /retro du projet
   (`telemetry/retro-AAAA-MM-JJ.md`, créé/complété tout de suite pour ne pas la
   perdre). Elle sera ajoutée au kit en session dédiée puis distribuée ; tant
   que ce n'est pas fait et tiré, une nouvelle session re-bootstrappe le domaine.

Ce bootstrap est devenu court par construction : un noyau régulé tient en une
page. Si ta référence dépasse, c'est que des conventions UI s'y sont glissées —
sors-les, elles appartiennent aux pistes.

## Références disponibles

- `references/fintech.md` — banque, paiement, épargne, investissement,
  assurance, crypto, KYC, produits régulés financiers.
- `references/paris-sportifs.md` — prédiction football & paris sportifs :
  probabilité implicite/vig, calibration, value betting, Kelly, ANJ.
<!-- Les nouveaux domaines s'ajoutent ici à mesure qu'ils sont bootstrappés -->

## Règle d'enrichissement

Tout apprentissage **métier** capté en /retro va, via son rapport (porté en
session kit), dans la référence du domaine actif (section "Règles ajoutées par
/retro" en bas de chaque référence), jamais dans les skills universels —
design-judgment, anti-slop et a11y restent agnostiques au domaine.

Un apprentissage **de goût** ne va pas ici : il va dans `design/da.md` du projet
si c'est un parti-pris projet, dans la bibliothèque d'exemplaires du kit si
c'est un écran validé à l'œil, ou dans le catalogue `ui-resources` si c'est une
ressource à ajouter ou à retirer.
