---
description: Pipeline complet de construction d'une feature, du challenge produit au rapport final
argument-hint: [description de la feature]
---

# /feature — Pipeline de construction

Feature demandée : $ARGUMENTS

Exécute ce pipeline dans l'ordre, sans sauter d'étape. Chaque étape produit un
livrable qui nourrit la suivante.

## Étape 1 — Challenge produit

Lance le subagent `product-challenger` avec le brief ET le CLAUDE.md du
projet (domaine, utilisateurs, spécificités — il ne reçoit pas ce contexte).
- S'il rend un verdict `rethink`, STOP : présente son analyse à Baptiste et
  attends sa décision. Ne construis rien.
- S'il liste des `infos_manquantes` : pose-les à Baptiste en UNE seule salve,
  écris les réponses dans le CLAUDE.md du projet (Domaine / Utilisateurs /
  Spécificités), puis relance le challenge si le scope en dépend. Ne comble
  jamais un trou en devinant.
- Sinon, récupère le **scope retenu** (la version minimale à forte valeur) et
  les critères de succès. C'est CE scope que tu construis, pas le brief initial.
- Si le challenger rend une `suite` (le brief était plusieurs features), tu ne
  construis que le premier maillon — le `scope_retenu`. La séquence restante
  remonte au rapport final ; chaque maillon sera lancé comme son propre
  /feature, en s'appuyant sur la mémoire `patterns/` accumulée entre-temps.

## Étape 2 — Direction artistique

`design/da.md` doit exister AVANT tout build d'UI :
- S'il existe : charge-le. C'est lui qui gouverne le build, avec le `@theme`
  qui en dérive.
- S'il manque et que la feature a une surface visuelle : exécute /da
  (références + proposition d'une direction unique). C'est un checkpoint
  Baptiste — attends sa validation avant de continuer. Une fois `da.md`
  écrit, tout l'aval est autonome.
- Feature sans surface visuelle (API, script, migration) : sans objet, note-le.

## Étape 3 — Recherche de patterns

1. Consulte d'abord `patterns/` : si un brief existant couvre ≥70% du sujet,
   utilise-le et passe à l'étape 4.
2. Sinon, lance le subagent `pattern-researcher` avec le scope retenu.
   Il rend un pattern brief d'une page max.
3. Sauvegarde ce brief dans `patterns/<sujet>.md` (format de `patterns/_template.md`).

## Étape 4 — Build

Construis le scope retenu en appliquant le DA brief et les skills
`design-judgment`, `anti-slop`, `a11y` et `domain-knowledge` (qui charge la
référence du domaine déclaré dans le CLAUDE.md du projet).
- Tokens uniquement : le `@theme` de l'entrypoint CSS du projet matérialise
  le contrat de tokens du kit (chemin injecté en début de session). S'il
  manque, le créer d'abord ; ne jamais écraser le template, ne jamais
  hardcoder une valeur.
- L'élément signature du DA brief doit être présent sur les écrans clés —
  c'est un livrable, pas une option.
- Tous les états des composants interactifs dès le premier jet.
- Commits atomiques avec messages clairs.

## Étape 5 — Vérification (gates machine + visuel, OBLIGATOIRE)

Lance d'abord les gates déterministes EXPLICITEMENT — ne présume jamais que
les hooks ont tiré (ils ne se chargent qu'au démarrage de la session, pas si
le plugin vient d'être installé ou rechargé) :
- JS/TS : `npx tsc --noEmit && npm run -s lint && npm run -s build`
- Python : `python3 -m py_compile` sur les fichiers modifiés, + `ruff`/`mypy`
  s'ils sont configurés.
Si une gate échoue, corrige avant d'aller plus loin.

Puis le visuel. Le goût se juge sur les pixels, pas sur le code. Démarre le
dev server et capture desktop + mobile :
```bash
npx playwright screenshot --viewport-size=1440,900 <url> /tmp/review-desktop.png
npx playwright screenshot --viewport-size=390,844 <url> /tmp/review-mobile.png
```
Si Playwright manque : `npm i -D playwright && npx playwright install chromium`.
Prépare cet outillage dès les étapes 1-3 (installation du navigateur pendant
la recherche, pas après le build). Si le projet n'a pas de script de capture
committé (`tools/screenshots.*`), crées-en un au premier build et committe-le :
les captures se rejouent à chaque tour de boucle de correction.
Si la capture est réellement impossible après tentative : l'hygiène s'audite
sur code, mais le goût N'EST PAS vérifié — le rapport le signale comme
limitation et le verdict design ne peut pas être `ship`.

## Étape 6 — Critique (parallèle)

Lance EN PARALLÈLE :
- `design-critic` — avec les screenshots, le scope retenu, le pattern brief,
  le DA brief (`design/da.md`) et ses captures (`design/references/`), et les
  chemins du contrat de tokens du kit + du `@theme` du projet (il ne reçoit
  pas le contexte de session). Exige la critique COMPARATIVE : rendu et
  références côte à côte. IMPORTANT : présente-lui le travail comme celui
  d'une équipe externe à auditer, jamais comme le tien.
- `code-reviewer` — avec les fichiers modifiés.

## Étape 7 — Boucle de correction

- S'il reste des issues `blocker` ou `major` : corrige-les TOUTES, puis relance
  les critics concernés. Maximum **3 tours**.
- Corrige les `minor` au passage, logge les `nit` sans les corriger.
- Si 3 tours atteints OU deux tours sans progrès matériel OU oscillation :
  STOP + rapport d'escalade.

## Étape 8 — Rapport final

Termine par un rapport court :
- **Shippé** : ce qui a été construit, écart éventuel avec le brief initial et pourquoi.
- **Verdicts** : synthèse des critics (nombre d'issues par sévérité, tours de boucle).
- **Goût** : le verdict du test du logo masqué et l'écart restant vs les
  références du DA brief (en 1-2 lignes, factuel).
- **Tranché** : les arbitrages faits en autonomie.
- **À décider** : ce qui mérite l'œil de Baptiste (ambiguïtés, dette notée, nits récurrents).
- **Suite** : si le brief était plusieurs features, la séquence ordonnée des
  prochains /feature (dépendances d'abord). Sinon, sans objet.
- **Preview** : URL Vercel si déployé.

Puis ajoute une ligne dans `telemetry/runs.jsonl`. Le champ `type` permet de
loguer aussi les sessions `critique` / `fix` / `retro` (compteurs critics
optionnels hors run de feature) — toute session de travail laisse une trace :
```json
{"date":"<ISO>","type":"feature","feature":"<nom>","tours":N,"blockers":N,"majors":N,"minors":N,"nits":N,"escalade":false,"dimensions_faibles":["..."]}
```
