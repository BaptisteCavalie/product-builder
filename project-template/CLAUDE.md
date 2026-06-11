# Projet — <nom>

Ce projet est construit avec le plugin `product-builder` : la constitution,
les pipelines, les critics et les gates sont injectés par le plugin à chaque
session. Ce fichier ne contient QUE le contexte propre au projet.

## Domaine

<!-- Le skill domain-knowledge lit cette section. /feature et /da demandent
     ce qui manque ici au lieu de le deviner, et y écrivent les réponses.
     Exemple :
     Domaine actif : fintech
     Utilisateurs : B2C, épargnants 25-45 ans, méfiants, mobile d'abord
     Spécificités : épargne, réglementation AMF -->
Domaine actif : (à déclarer — si absent, le système demande avant de construire)
Utilisateurs : (qui + état d'esprit — demandé par /da et /feature si absent)

## Kit

Clone local du kit : <chemin absolu, ex. ~/product-builder-kit>
<!-- Utilisé par /product-builder:retro et le bootstrap de références métier :
     les amendements s'écrivent dans le clone du kit (puis commit + push),
     jamais dans le cache du plugin. -->

## Design

- `design/da.md` — le DA brief du projet (produit par /product-builder:da,
  validé par Baptiste) : ambiance, références, typographie nommée, élément
  signature. AUCUN build d'UI sans lui.
- Le `@theme` de l'entrypoint CSS (ex. `app/globals.css`) dérive du DA brief
  et matérialise le contrat de tokens du kit — seule source de valeurs
  visuelles du projet (projet sans Tailwind : mêmes noms de tokens dans le
  `:root` de l'entrypoint CSS). Le chemin du contrat est injecté en début de
  session par le plugin.

## Spécificités projet

<!-- Conventions, contraintes, décisions d'archi propres à ce projet. -->
