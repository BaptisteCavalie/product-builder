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

- En début de session kit : lire `docs/en-attente.md` (les actions que seul
  Baptiste peut faire — validations d'exemplaires, captures à fournir) et
  signaler les lignes qui dorment. C'est le pendant humain des gates.
- Tester : `claude --plugin-dir ./product-builder`, puis `/reload-plugins`
  après chaque modif.
- Valider avant push : `claude plugin validate ./product-builder`,
  `claude plugin validate .` (marketplace), ET
  `./product-builder/scripts/check-doctrine.sh` (cohérence des doctrines
  multi-fichiers — gate déterministe, pas seulement la vigilance).
- La CI (`.github/workflows/ci.yml`) rejoue ces gates à chaque push/PR :
  check-doctrine, check-exemplars, syntaxe bash, JSON des manifests,
  autotest check-theme. La production (push sur main) n'est plus gardée
  par la seule machine locale.
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

## Doctrine visual craft (ajoutée le 11/06/2026)

La théorie générative du goût vit dans deux skills : `skills/color` (palette,
OKLCH, rampes, sémantiques) et `skills/art-direction` (typo, composition,
motion, retenue senior). Le format des valeurs couleur (oklch() web / HEX repli
email) est aussi posé en en-tête de `design-system/tokens.css` et vérifié par
les blocs « Couleur & système » et « Composition & motion » de
`agents/design-critic.md`. Garder ces quatre points alignés — même règle que la
doctrine tokens : deux formulations divergentes = incident.

Même famille, ajoutées le 07/07/2026 (vérifiées par `check-doctrine.sh`) :
**motion en tokens** (`--duration-*`/`--ease-*` dans le contrat ; posée dans
`tokens.css`, `constitution.md`, `skills/art-direction`, `agents/design-critic`)
et **dark = rampe sombre dédiée, jamais une inversion** (posée dans
`tokens.css`, `design-system/README.md`, `skills/color`).

## /retro

Une session projet ne mute JAMAIS le kit. /retro, exécuté depuis un projet,
écrit seulement les amendements PROPRES au projet (CLAUDE.md du projet,
`design/da.md`, télémétrie) et produit un **rapport**
(`telemetry/retro-AAAA-MM-JJ.md`) des amendements KIT. Baptiste copie-colle ce
rapport dans une session dédiée à CE repo : c'est elle qui écrit les
amendements dans les fichiers de `product-builder/` (et `docs/pipeline.md`),
puis commit + push pour les distribuer. Les amendements kit arrivent donc ICI
via un rapport collé, jamais via une session projet.

**Exception — /retro lancé DANS ce repo (kit-self).** Projet = kit : pas de
frontière à franchir, donc pas de rapport/handoff. /retro applique alors ses
amendements directement ici (validés un par un), puis commit + push. Voir le
« Cas particulier » de `product-builder/commands/retro.md`.

**Tracer l'intake (sinon un rapport non porté = apprentissage perdu).** À
chaque rapport /retro appliqué dans une session kit, ajoute une ligne dans
`docs/kit-intake.md` (date du rapport, projet d'origine, nb d'amendements,
commit). C'est le registre qui rend détectable un rapport oublié — la couture
copier-coller du /retro est manuelle, ce journal la rend auditable.
