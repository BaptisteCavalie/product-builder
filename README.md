# Product Builder — équipe produit senior autonome

Un système Claude Code qui transforme un brief de feature en produit shippé,
avec une boucle qualité qui ne dépend pas de ta vigilance : challenge produit
en amont, recherche de patterns distillée, build contraint par design system,
gates machine déterministes, critics à sévérité, et apprentissage cumulatif
de ton goût via `/retro`.

## Installation

### Sur un projet existant
Copier `CLAUDE.md`, `.claude/`, `patterns/`, `design-system/`, `telemetry/`
à la racine du projet. Si un `CLAUDE.md` existe déjà, fusionner.

### Sur un nouveau projet
```bash
npx create-next-app@latest mon-projet --typescript --tailwind --app
# puis copier le contenu de ce kit à la racine
cd mon-projet && claude
```

### Prérequis & options
- Hooks : `jq` recommandé (`brew install jq`) — fallback inclus sinon.
- Code mort : `npm i -D knip` puis `npx knip --init` (la gate Stop le
  détecte automatiquement s'il est configuré).
- Screenshots : `npm i -D playwright && npx playwright install chromium`.
- Mobbin MCP (plan payant requis) :
  ```bash
  claude mcp add mobbin --scope user --transport http https://api.mobbin.com/mcp
  ```
  puis `/mcp` dans Claude Code pour authentifier.
- Scripts `package.json` attendus par la gate : `lint` et idéalement `typecheck`
  (`"typecheck": "tsc --noEmit"`).

## Usage quotidien

```
/feature "onboarding KYC pour une app d'épargne"   # le pipeline complet
/critique "la page /dashboard"                      # audit sans build
/retro                                              # fin de session : apprentissage
```

C'est tout. Le pipeline `/feature` enchaîne : challenge produit → recherche
patterns (library locale puis Mobbin) → build → screenshots → critics en
parallèle → boucle de correction (max 3 tours) → rapport final.

## Comment le système apprend

1. **Pendant la session** : chaque correction ou reproche que tu fais est un signal.
2. **`/retro`** les transforme en règles générales, proposées une par une.
3. **Tu valides** → la règle est écrite dans le skill concerné, à jamais.
4. **`telemetry/runs.jsonl`** trace les verdicts ; une faiblesse récurrente
   sur ≥3 runs révèle un trou structurel dans un skill.

Plus tu l'utilises et fais `/retro`, plus les skills contiennent TON jugement.
C'est l'actif du système — versionne-le en git comme du code.

## Architecture

| Étage | Rôle | Où |
|---|---|---|
| Constitution | valeurs, arbitrages, non-négociables, **domaine actif** | `CLAUDE.md` |
| Pipelines | l'orchestration, écrite noir sur blanc | `.claude/commands/` |
| Critics | jugement isolé, verdicts par sévérité | `.claude/agents/` |
| Connaissance universelle | design-judgment, anti-slop, a11y — agnostique au domaine | `.claude/skills/` |
| Connaissance métier | une référence par domaine, routée par `domain-knowledge` | `.claude/skills/domain-knowledge/references/` |
| Gates | vérifs déterministes, exit 2 = reboucle | `.claude/hooks/` |
| Mémoire produit | pattern briefs cumulatifs | `patterns/` |
| Contrat visuel | tokens, seule source de valeurs | `design-system/` |

**Changer de domaine** = déclarer `Domaine actif : <x>` dans le CLAUDE.md du
projet. Si la référence n'existe pas encore, le système la bootstrappe
(pattern-researcher) et te la fait valider. `fintech.md` est fournie ;
chaque nouveau projet dans un nouveau secteur enrichit le deck.

Règle de calibration des critics : s'ils sont trop gentils ou trop sévères,
ne corrige pas leurs verdicts à la main — amende leur rubrique via `/retro`.

## Distribuer (le tamagotchi)

Quand le kit est calibré sur 2-3 projets, le packager en plugin Claude Code
pour l'installer en une commande partout (et le partager au Dojo) :
https://docs.claude.com/en/docs/claude-code/plugins
