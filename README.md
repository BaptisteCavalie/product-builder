# Product Builder — équipe produit senior autonome

Un plugin Claude Code qui transforme un brief de feature en produit shippé,
avec une boucle qualité qui ne dépend pas de ta vigilance : challenge produit
en amont, recherche de patterns distillée, build contraint par design system,
gates machine déterministes, critics à sévérité, et apprentissage cumulatif
de ton goût via `/product-builder:retro`.

Ce repo est à la fois la **marketplace** (`.claude-plugin/marketplace.json`)
et la **source du plugin** (`product-builder/`). Tu améliores le kit ici, tu
push, et tous les projets qui l'utilisent reçoivent la mise à jour au prochain
démarrage de session — aucune copie manuelle.

## Installation sur un projet

### Nouveau projet
```bash
npx create-next-app@latest mon-projet --typescript --tailwind --app
cd mon-projet
# copier le contenu de project-template/ à la racine :
#   CLAUDE.md (compléter domaine + chemin du clone du kit)
#   .claude/settings.json, patterns/, design/, telemetry/
claude   # propose automatiquement d'installer le plugin (via settings.json)
```

### Projet existant
Copier le contenu de `project-template/` à la racine (fusionner le CLAUDE.md
s'il en existe un), ou installer manuellement :
```
/plugin marketplace add BaptisteCavalie/product-builder
/plugin install product-builder@product-builder-kit
```

### Mise à jour
Rien à faire : sans champ `version`, chaque commit poussé sur ce repo est une
nouvelle version et l'auto-update tourne au démarrage des sessions. Pour
forcer immédiatement : `/plugin marketplace update product-builder-kit` puis
`/plugin update product-builder`. Repo privé : exporter `GITHUB_TOKEN` pour
que l'auto-update en arrière-plan puisse s'authentifier.

### Prérequis & options
- Hooks : `jq` recommandé (`brew install jq`) — fallback inclus sinon.
- Code mort : `npm i -D knip` puis `npx knip --init` (la gate Stop le
  détecte automatiquement s'il est configuré).
- Screenshots : `npm i -D playwright && npx playwright install chromium`.
- Test du risque : un runner (`vitest`, ou `node --test` natif) si tu shippes
  de la logique à risque (argent, auth, irréversible). Le code-reviewer ne
  réclame un test que là — jamais sur l'UI.
- Mobbin MCP (plan payant requis) :
  ```bash
  claude mcp add mobbin --scope user --transport http https://api.mobbin.com/mcp
  ```
  puis `/mcp` dans Claude Code pour authentifier.
- Scripts `package.json` attendus par la gate : `lint` et idéalement `typecheck`
  (`"typecheck": "tsc --noEmit"`).

## Usage quotidien

```
/product-builder:da "app de pronostics entre amis"                  # direction artistique (1x par projet)
/product-builder:feature "onboarding KYC pour une app d'épargne"   # le pipeline complet
/product-builder:critique "la page /dashboard"                      # audit sans build
/product-builder:retro                                              # fin de session : apprentissage
```

C'est tout. Le pipeline `feature` enchaîne : challenge produit → DA brief
(s'il manque, /da le crée — seul checkpoint humain) → recherche patterns
(library locale puis Mobbin) → build → screenshots (obligatoires : le goût
se juge sur les pixels) → critics en parallèle, critique comparative contre
les références du DA brief → boucle de correction (max 3 tours) → rapport final.

Le détail du flux, en arbres de décision oui/non (vue d'ensemble + zooms sur
challenge, /da, gates de goût du build, critique) : [`docs/pipeline.md`](docs/pipeline.md).

`/da` collecte les références multi-sources — bibliothèque d'exemplaires du
kit, Mobbin (produits réels), Awwwards/Godly/SiteInspire (direction
artistique web), Dribbble (ambiance uniquement, jamais les layouts), Fonts
In Use (typographie) — puis tranche UNE direction : ambiance, police nommée,
palette, élément signature. Le `@theme` du projet en dérive (projet sans
Tailwind : mêmes noms de tokens dans le `:root` de l'entrypoint CSS).

## Comment le système apprend

1. **Pendant la session** : chaque correction ou reproche que tu fais est un signal.
2. **`/product-builder:retro`** distille ces signaux : il applique sur place les
   apprentissages propres au projet et rédige un **rapport ultra-détaillé** des
   amendements destinés au kit (`telemetry/retro-AAAA-MM-JJ.md`). Une session
   projet ne touche jamais le kit.
3. **Tu portes le volet kit du rapport** dans une session dédiée à ce repo :
   elle écrit les règles, commit + push — elles sont distribuées à tous tes
   projets, à jamais.
4. **`telemetry/runs.jsonl`** (par projet) trace les verdicts ; une faiblesse
   récurrente sur ≥3 runs révèle un trou structurel dans un skill.

Plus tu l'utilises et fais `/retro`, plus les skills contiennent TON jugement.
C'est l'actif du système — ce repo est sa mémoire versionnée.

## Architecture

| Étage | Rôle | Où |
|---|---|---|
| Constitution | valeurs, arbitrages, non-négociables — injectée à chaque session (hook SessionStart) | `product-builder/constitution.md` |
| Pipelines | l'orchestration, écrite noir sur blanc | `product-builder/commands/` |
| Critics | jugement isolé, verdicts par sévérité | `product-builder/agents/` |
| Connaissance universelle | design-judgment, art-direction, color, ux-writing, anti-slop, a11y — agnostique au domaine | `product-builder/skills/` |
| Connaissance métier | une référence par domaine, routée par `domain-knowledge` | `product-builder/skills/domain-knowledge/references/` |
| Gates | vérifs déterministes, exit 2 = reboucle | `product-builder/hooks/` |
| Contrat visuel | contrat de tokens (template) — valeurs compilées dans le `@theme` du projet | `product-builder/design-system/` |
| Goût | bibliothèque d'exemplaires (écrans validés, annotés) + DA brief par projet | `product-builder/design-system/references/` + `design/` (projet) |
| Côté projet | CLAUDE.md mince (domaine actif), pattern briefs, DA brief, télémétrie, `@theme` | `project-template/` |

**Changer de domaine** = déclarer `Domaine actif : <x>` dans le CLAUDE.md du
projet. Si la référence n'existe pas encore, le système la bootstrappe
(pattern-researcher), te la fait valider, puis l'inscrit dans le rapport /retro
pour l'ajouter au kit (session dédiée) et la partager. `fintech.md` est fournie ;
chaque nouveau projet dans un nouveau secteur enrichit le deck.

Règle de calibration des critics : s'ils sont trop gentils ou trop sévères,
ne corrige pas leurs verdicts à la main — amende leur rubrique via `/retro`.

## Développer le kit

```bash
claude --plugin-dir ./product-builder   # tester sans installer
/reload-plugins                          # recharger après une modif
claude plugin validate ./product-builder # valider avant push
```

Pour le partager au-delà de tes machines (le Dojo) : soumettre le plugin à la
marketplace communautaire — https://code.claude.com/docs/en/plugins
