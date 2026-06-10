# Design system

`tokens.css` est la source de vérité. Trois règles d'usage :

1. **Zéro valeur hors tokens.** Besoin d'une valeur qui n'existe pas ?
   On discute du token AVANT, on ne hardcode jamais.
2. **L'accent est un signal.** S'il apparaît sur un élément non interactif
   et non sémantique, c'est probablement du slop (cf. skill anti-slop).
3. **Par projet** : remplacer `--color-accent` (+ hover/subtle) et
   éventuellement `--font-sans` selon la DA. Le reste bouge rarement.

À terme : ce dossier accueille les composants de base réutilisables
(Button, Input, Card, Toast…) construits sur ces tokens — et il sert de
contrat partagé lisible par Figma MCP et Claude Design.
