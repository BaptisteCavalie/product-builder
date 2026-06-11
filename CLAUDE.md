# Product Builder Kit — repo source du plugin

Ce repo n'est PAS un projet produit : c'est la source du plugin
`product-builder` et sa marketplace. Une session ici sert à développer le
kit lui-même. La constitution produit vit dans
`product-builder/constitution.md` — c'est elle qui est injectée dans les
projets consommateurs, pas ce fichier.

## Structure

- `.claude-plugin/marketplace.json` — le repo EST la marketplace
  (`product-builder-kit`).
- `product-builder/` — le plugin : `commands/` (pipelines), `agents/`
  (critics), `skills/` (connaissance), `hooks/` (gates déterministes +
  injection de la constitution au SessionStart), `constitution.md`,
  `design-system/` (contrat de tokens + `references/`, la bibliothèque
  d'exemplaires : le goût validé de Baptiste, en images annotées).
- `project-template/` — ce qu'un projet consommateur garde en propre :
  CLAUDE.md mince (domaine + spécificités), `.claude/settings.json`
  (pointeur marketplace + plugin), `patterns/`, `design/` (DA brief
  produit par /da + captures de références), `telemetry/`.

## Développer le kit

- Tester : `claude --plugin-dir ./product-builder`, puis `/reload-plugins`
  après chaque modif.
- Valider avant push : `claude plugin validate ./product-builder` et
  `claude plugin validate .` (marketplace).
- `plugin.json` n'a **pas** de champ `version`, c'est voulu : chaque commit
  est une version, et les projets s'auto-mettent à jour au démarrage de
  session. **Push = mise en production du kit.**
- Les scripts de `product-builder/hooks/` référencent leurs fichiers via
  `${CLAUDE_PLUGIN_ROOT}` (le cache d'installation), jamais en relatif au
  projet.

## Doctrine tokens (tranchée le 11/06/2026, ne pas re-trancher)

`design-system/tokens.css` = contrat de catégories (template générique,
jamais écrasé par des valeurs projet). La source compilée d'un projet est le
`@theme` de son entrypoint CSS — Tailwind v4 ne génère rien depuis `:root`.
Cette doctrine est écrite dans : `product-builder/design-system/README.md`,
`product-builder/design-system/tokens.css`, `product-builder/constitution.md`,
`product-builder/commands/feature.md`, `product-builder/agents/design-critic.md`,
`project-template/CLAUDE.md` et le README racine. Toute modification doit
garder ces fichiers alignés — deux formulations divergentes de cette règle
ont déjà causé un incident.

## /retro

Les amendements de /retro, exécuté depuis n'importe quel projet, s'écrivent
ICI (dans les fichiers de `product-builder/`), puis commit + push pour les
distribuer. Le CLAUDE.md de chaque projet déclare le chemin de ce clone.
