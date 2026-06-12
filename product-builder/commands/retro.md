---
description: Rétrospective de session — distille les corrections de Baptiste en un rapport d'apprentissages à porter dans une session kit dédiée
---

# /retro — La boucle d'apprentissage

C'est par cette commande que le système s'améliore. Exécute en fin de session.

**Séparation projet / kit (non négociable).** Une session projet ne mute
JAMAIS le kit. /retro distille les signaux en deux flux distincts :
- **côté projet** (CLAUDE.md du projet, `design/da.md`, télémétrie) → écrit
  directement ICI, après validation : ce ne sont pas des changements du kit ;
- **côté kit** (skills, agents, commandes, constitution, références métier,
  bibliothèque d'exemplaires, pipeline) → JAMAIS écrit ici. Produit un
  **rapport ultra-détaillé** que Baptiste copie-colle dans une session dédiée
  au repo du kit ; cette session-là applique, commit et push (= distribution).

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

## 2. Trie chaque signal : projet ou kit ?

Pour chaque signal, décide sa cible — elle détermine son flux.

**Côté kit (→ rapport, §4) — chemins relatifs au repo du kit**
- goût visuel récurrent → le bon skill selon la nature :
  interdit/réflexe à bannir → `anti-slop` ; principe d'utilisabilité →
  `design-judgment` ; couleur/palette → `color` ; typo/composition/motion/
  retenue → `art-direction` (tous dans `product-builder/skills/`)
- écran que Baptiste a validé/aimé → nouvel exemplaire (capture + ligne
  d'index) dans `product-builder/design-system/references/`
  (la bibliothèque d'exemplaires — le goût positif se capitalise en images,
  pas seulement en interdits)
- accessibilité → `product-builder/skills/a11y/SKILL.md`
- domaine métier → `product-builder/skills/domain-knowledge/references/<domaine actif>.md`
  (si un domaine a été bootstrappé pendant la session, sa référence complète est
  déjà consignée dans le rapport par domain-knowledge — vérifie-la, ne la duplique pas)
- critère de jugement mal calibré → l'agent critic concerné dans `product-builder/agents/`
- processus / arbitrage → `product-builder/constitution.md` ou la commande
  concernée dans `product-builder/commands/`
- changement de pipeline → le diagramme concerné dans `docs/pipeline.md`

**Côté projet (→ écrit directement, §3)**
- direction artistique propre au projet (ambiance, typo, signature) →
  `design/da.md` du projet
- contexte propre au projet (pas généralisable) → le CLAUDE.md du projet

Règles de rédaction d'une règle (valent pour les deux flux) :
- **Généralise** : pas "Baptiste n'a pas aimé l'ombre sur la card pricing" mais
  "Pas d'ombre portée sur les cards de contenu statique ; réserver l'élévation
  aux éléments flottants (modales, dropdowns, toasts)".
- Une règle = une ligne testable. Si on ne peut pas vérifier qu'elle est
  respectée, reformule.
- Vérifie qu'elle ne contredit pas une règle existante. Si conflit, propose
  la résolution explicitement.

## 3. Amendements côté projet — applique directement

Présente-les en liste numérotée (fichier cible, règle proposée, citation
courte) et attends la validation de Baptiste **amendement par amendement**.
N'écris RIEN sans validation. Écris ensuite les amendements validés dans les
fichiers du projet. C'est le repo du projet : aucun push du kit ici.

## 4. Amendements côté kit — rédige le rapport

Écris UN fichier `telemetry/retro-AAAA-MM-JJ.md` dans le projet (si une session
a déjà retro'é aujourd'hui, ajoute une section datée à l'heure plutôt que
d'écraser) et affiche-le aussi en fin de réponse.

Le rapport doit être **autosuffisant** : une session kit qui ne lit QUE ce
fichier, sans le contexte de cette session projet, doit pouvoir appliquer
chaque changement sans rien deviner. C'est le critère de qualité du rapport.

### En-tête
- Projet + domaine actif.
- Date + résumé de session en 1-2 lignes (ce qui a été construit / critiqué).

### Pour CHAQUE amendement kit, un bloc complet
1. **Fichier cible** — chemin relatif au repo du kit (ex.
   `product-builder/skills/anti-slop/SKILL.md`) + section/rubrique exacte où
   insérer.
2. **Type** — nouvelle règle | modif d'une règle existante | nouvel exemplaire |
   recalibrage critic | changement de process/pipeline.
3. **Texte prêt à coller** — la règle exacte, déjà généralisée et testable,
   formatée comme les lignes voisines du fichier cible.
4. **Signal d'origine** — citation verbatim de Baptiste + le contexte (quel
   écran / feature / moment de la session).
5. **Cohérence** — ne contredit pas une règle existante ? Si conflit, la
   résolution proposée. Si la règle touche une **doctrine multi-fichiers**
   (tokens, visual craft, /retro, pipeline), LISTER tous les fichiers à mettre
   à jour dans le même commit côté kit — sinon, incident.

### Exemplaires (captures) — cas particulier
Une image ne se copie-colle pas en texte. Pour chaque écran validé à
capitaliser :
- sauve la capture côté projet dans
  `telemetry/retro-assets/<domaine>-<app>-<écran>.png` (crée le dossier au
  besoin) ;
- dans le rapport : la ligne d'index prête à coller
  (`<fichier>.png — app/écran — pourquoi c'est bien (1 ligne) — domaine`), le
  chemin du PNG sauvé, et l'URL déployée si elle existe ;
- consigne explicite : porter le PNG dans
  `product-builder/design-system/references/` de la session kit — le texte du
  rapport seul ne suffit pas pour les exemplaires.

## 5. Télémétrie + bilan

- Ajoute la ligne de télémétrie de la session dans `telemetry/runs.jsonl` du
  projet si ce n'est pas déjà fait.
- Si la télémétrie récente montre un pattern (même dimension faible sur ≥3
  runs → trou structurel probable dans un skill), inscris-le comme amendement
  kit dans le rapport ET signale-le dans le bilan.
- Termine la réponse par : le chemin du rapport, le nombre d'amendements kit
  qu'il contient, le nombre d'amendements projet appliqués, et la prochaine
  étape manuelle pour Baptiste — ouvrir une session dans le repo du kit, coller
  le rapport, porter les éventuels PNG, valider, commit + push (c'est ce push
  qui distribue les règles à tous les projets au prochain démarrage de session).
