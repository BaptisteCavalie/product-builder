---
description: Rétrospective de session — transforme les corrections de Baptiste en règles permanentes dans les skills
---

# /retro — La boucle d'apprentissage

C'est par cette commande que le système s'améliore. Exécute en fin de session.

## 1. Relis la session

Parcours la conversation et identifie :
- chaque correction manuelle de Baptiste (code, design, copy, scope) ;
- chaque reproche ou désaccord exprimé, même en passant ("non pas comme ça",
  "je préfère", "c'est moche", "trop chargé") ;
- chaque signal POSITIF explicite sur un écran ("ça c'est bien", "j'adore",
  validation enthousiaste) — un écran aimé est un exemplaire candidat, aussi
  précieux qu'un reproche ;
- chaque question qu'il a dû poser parce qu'une info manquait au rapport ;
- les issues critics qu'il a ignorées ou contredites (signal que la rubrique
  est mal calibrée).

## 2. Transforme en amendements

Les amendements s'écrivent dans le **clone local du kit** (chemin déclaré à la
section `## Kit` du CLAUDE.md du projet ; si la session tourne déjà dans le
repo du kit, c'est le repo courant ; sinon demande le chemin à Baptiste).
JAMAIS dans le cache du plugin installé — il serait écrasé à la prochaine
mise à jour.

Pour chaque signal, propose un amendement à UN fichier précis (chemins
relatifs au clone du kit) :
- goût visuel récurrent → le bon skill selon la nature :
  interdit/réflexe à bannir → `anti-slop` ; principe d'utilisabilité →
  `design-judgment` ; couleur/palette → `color` ; typo/composition/motion/
  retenue → `art-direction` (tous dans `product-builder/skills/`)
- écran que Baptiste a validé/aimé → capture (screenshot du rendu) +
  ligne d'index dans `product-builder/design-system/references/`
  (la bibliothèque d'exemplaires — le goût positif se capitalise en images,
  pas seulement en interdits)
- accessibilité → `product-builder/skills/a11y/SKILL.md`
- domaine métier → `product-builder/skills/domain-knowledge/references/<domaine actif>.md`
- critère de jugement mal calibré → l'agent critic concerné dans `product-builder/agents/`
- processus / arbitrage → `product-builder/constitution.md` ou la commande
  concernée dans `product-builder/commands/`
- direction artistique propre au projet (ambiance, typo, signature) →
  `design/da.md` du projet (cible projet, comme le CLAUDE.md)
- contexte propre au projet (pas généralisable) → le CLAUDE.md du projet

Règles de rédaction d'un amendement :
- **Généralise** : pas "Baptiste n'a pas aimé l'ombre sur la card pricing" mais
  "Pas d'ombre portée sur les cards de contenu statique ; réserver l'élévation
  aux éléments flottants (modales, dropdowns, toasts)".
- Une règle = une ligne testable. Si on ne peut pas vérifier qu'elle est
  respectée, reformule.
- Vérifie qu'elle ne contredit pas une règle existante. Si conflit, propose
  la résolution explicitement.

## 3. Validation

Présente les amendements en liste numérotée : fichier cible, règle proposée,
signal d'origine (citation courte). Attends la validation de Baptiste
**amendement par amendement**. N'écris RIEN dans les skills sans validation.

## 4. Applique, logge, distribue

- Écris les amendements validés dans les fichiers cibles du clone du kit.
- Commit dans le kit (message : `retro: <résumé>`) et propose le push à
  Baptiste — c'est le push qui distribue les règles : chaque projet reçoit
  le kit à jour au prochain démarrage de session.
- Ajoute la ligne de télémétrie de la session dans `telemetry/runs.jsonl`
  **du projet** si ce n'est pas déjà fait.
- Termine par : nombre de règles ajoutées, et s'il y a un pattern dans la
  télémétrie récente (même dimension faible sur ≥3 runs → signale que le
  skill correspondant a probablement un trou structurel).
