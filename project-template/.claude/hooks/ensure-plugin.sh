#!/usr/bin/env bash
#
# Hook SessionStart — installe le plugin `product-builder` s'il est absent.
#
# POURQUOI CE FICHIER EXISTE, ET POURQUOI IL EST COPIÉ DANS CHAQUE PROJET
# `.claude/settings.json` déclare le plugin (extraKnownMarketplaces +
# enabledPlugins) mais ne l'installe pas. En local ça suffit : le cache
# utilisateur (~/.claude/plugins) persiste d'une session à l'autre, la
# déclaration se résout dessus.
#
# En session cloud, non : le conteneur est éphémère et le dépôt est cloné à
# neuf, donc le cache marketplace est vide. Déclarer un marketplace ne le
# récupère pas — /da, /critique, /feature et /retro sont purement absents, et
# la session improvise au lieu d'exécuter le pipeline. Ce hook comble ce trou.
#
# Il ne peut PAS vivre dans le plugin : c'est lui qui installe le plugin. La
# copie dans chaque projet dérivé est donc structurelle, pas une négligence.
#
# ⚠️ NE PAS CONFONDRE avec `product-builder/hooks/session-start.sh`, qui est le
# hook DU plugin (il injecte la constitution) et ne tourne que si le plugin est
# déjà installé. D'où le nom distinct de ce fichier.
#
# Le stdout d'un SessionStart devient du contexte de session : ce script dit
# donc explicitement si les commandes sont utilisables MAINTENANT ou seulement
# au prochain démarrage. Le registre des commandes est construit au lancement ;
# une installation faite pendant ce hook n'y entre pas forcément.
#
# Ne fait jamais échouer la session : sort 0 en toutes circonstances.
#
# Origine : écrit pour boussole-mentorat, remonté dans le project-template le
# 2026-09-09 (cf. telemetry/retro-2026-07-29.md).

set -uo pipefail

MARKETPLACE="product-builder-kit"
PLUGIN="product-builder@${MARKETPLACE}"
REPO="BaptisteCavalie/product-builder"

installe() { claude plugin list 2>/dev/null | grep -Fq "$PLUGIN"; }

if ! command -v claude >/dev/null 2>&1; then
  echo "product-builder : CLI \`claude\` introuvable — installation impossible."
  echo "Les commandes /da, /critique, /feature, /retro sont absentes."
  exit 0
fi

# Cache déjà chaud (cas local) : le registre a pu charger le plugin au
# démarrage, les commandes sont normalement disponibles.
if installe; then
  cat <<'MSG'
product-builder : déjà installé (cache chaud) — /da, /critique, /feature et
/retro sont normalement chargés. S'ils sont introuvables malgré ce message,
c'est que le plugin a été installé après la construction du registre : le dire
et redémarrer, ne pas improviser le pipeline.
MSG
  exit 0
fi

echo "product-builder absent (conteneur neuf) — installation…"
timeout 150 claude plugin marketplace add "$REPO" >/dev/null 2>&1
timeout 60 claude plugin install "$PLUGIN" >/dev/null 2>&1

if installe; then
  cat <<'MSG'
product-builder installé à l'instant.

ATTENTION : l'installation a eu lieu PENDANT le démarrage. Si /da, /critique,
/feature ou /retro sont introuvables, c'est que le registre des commandes avait
déjà été construit — le plugin ne sera chargé qu'au prochain démarrage. Dans ce
cas, ne pas improviser le pipeline : le dire et redémarrer la session.
MSG
else
  cat <<'MSG'
product-builder : installation ÉCHOUÉE (réseau ou dépôt inaccessible).
Les commandes /da, /critique, /feature, /retro sont absentes. Ne pas les
simuler : signaler l'échec.
MSG
fi

exit 0
