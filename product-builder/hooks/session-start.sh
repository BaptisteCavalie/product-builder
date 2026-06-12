#!/usr/bin/env bash
# Hook SessionStart — injecte la constitution et les chemins du kit dans le
# contexte de chaque session. Le stdout d'un SessionStart devient du contexte.

set -uo pipefail
ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

cat "$ROOT/constitution.md"

cat <<EOF

## Chemins du kit (résolus pour cette session)

- Contrat de tokens : $ROOT/design-system/tokens.css
- Principes du design system : $ROOT/design-system/README.md
- Bibliothèque d'exemplaires (goût validé, en images) : $ROOT/design-system/references/
- Capture de références (Playwright, viewport 1440×900) : $ROOT/scripts/capture-ref.sh

Transmets ces chemins aux subagents (critics, pattern-researcher) qui en ont
besoin : ils ne reçoivent pas ce contexte automatiquement.

Rappel : aucun build d'UI sans \`design/da.md\` dans le projet — s'il manque,
/da d'abord (cf. constitution).
EOF
