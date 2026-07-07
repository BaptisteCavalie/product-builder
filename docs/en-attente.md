# Actions en attente de Baptiste

Registre des actions que seul Baptiste peut faire — le pendant humain de
`kit-intake.md`. Les gates attrapent ce que le kit oublie ; ce fichier attrape
ce que Baptiste laisse en suspens. À relire en début de session kit ; une
ligne réglée se raye (avec la date) plutôt qu'elle ne s'efface.

| Depuis | Action | Où / comment |
|---|---|---|
| 2026-06-17 | **Valider à l'œil les 8 exemplaires « proposés »** (Qonto, Revolut, Kraken, Fey, Linear, Perplexity, Cursor, Things) : les survivants passent « validé », les recalés se retirent. | `product-builder/design-system/references/` — regarder chaque PNG, mettre à jour le statut dans le README de la bibliothèque. |
| 2026-06-17 | **Fournir la capture BNP Mes Comptes** — borne BASSE du curseur d'audace, absente de Mobbin. Le curseur reste calibré sur 2 bornes sur 3 tant qu'elle manque. | Capture perso → `fintech-bnp-comptes.png` dans la bibliothèque + déplacer la ligne « En attente de capture » vers l'index (même commit, gate `check-exemplars.sh`). |
| 2026-06-13 | **Porter les 2 PNG du portfolio** (home dark + fiche projet dark) dont le « pourquoi » est validé depuis le /retro du 13/06. | Même mécanique que BNP — les lignes attendent dans le bloc commenté du README de la bibliothèque. |
| 2026-06-17 | **Élargir la bibliothèque par le haut : exemplaires hors-UI** (éditorial print, affiche, type specimens) — non couvert par Mobbin, à sourcer via /da ou à l'occasion. | Sourcing manuel ou premier /da qui vise le haut du curseur. |

Historique : le diagnostic et le plan « œil visuel » qui vivaient ici
(`wip-oeil-visuel.md`) ont été intégrés au kit le 2026-06-17 (curseur
d'audace, sourcing hors-UI, bibliothèque curée — voir l'historique git).
Ne restait que la liste ci-dessus.
