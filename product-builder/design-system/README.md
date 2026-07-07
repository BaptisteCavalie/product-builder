# Design system

`tokens.css` définit le **contrat de catégories** : quelles familles de
tokens existent, leurs noms, et comment les utiliser. C'est un template
générique à valeurs placeholder — ne jamais l'écraser avec des valeurs projet.

Tailwind v4 ne génère aucun utilitaire depuis `:root` : la source compilée
de chaque projet est le bloc `@theme` de son entrypoint CSS (`globals.css`),
qui matérialise les catégories de ce contrat avec les valeurs du projet.
Projets sans Tailwind : mêmes noms de tokens dans le `:root` de l'entrypoint
CSS — le contrat est agnostique du framework.

Quatre règles d'usage :

1. **Zéro valeur hors tokens.** Besoin d'une valeur qui n'existe pas dans
   le `@theme` du projet ? On discute du token AVANT, on ne hardcode jamais.
   Vaut aussi pour la motion : durées et easings viennent de
   `--duration-*` / `--ease-*`, jamais en dur dans un composant.
2. **L'accent est un signal.** S'il apparaît sur un élément non interactif
   et non sémantique, c'est probablement du slop (cf. skill anti-slop).
3. **Par projet** : matérialiser le contrat dans le `@theme` en remplaçant
   `--color-accent` (+ hover/subtle) et éventuellement `--font-sans` selon
   la DA. Le reste bouge rarement.
4. **Dark = une rampe sombre dédiée, jamais une inversion.** Même contrat,
   mêmes noms : les valeurs sombres se redéclarent dans un bloc dédié de
   l'entrypoint (`[data-theme="dark"]` ou media query), construites selon
   le skill `color` (§ dark) ; le contraste se re-prouve séparément.

À terme : ce dossier accueille les composants de base réutilisables
(Button, Input, Card, Toast…) construits sur ces tokens — et il sert de
contrat partagé lisible par Figma MCP et Claude Design.
