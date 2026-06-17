# Bibliothèque d'exemplaires — le goût validé, en images

Le pendant visuel de la pattern library : des écrans que Baptiste a validés
ou aimés, avec le POURQUOI. Les règles (anti-slop) fixent le plancher ; les
exemplaires fixent le plafond — un modèle imite un bon exemple bien mieux
qu'il n'obéit à un adjectif.

Règles :
- Un exemplaire = une image (`<domaine>-<app>-<écran>.png`) + une ligne d'index
  ci-dessous. Sans le pourquoi, l'image ne vaut rien.
- Une ligne d'index ne devient « live » (dans `## Index`) qu'une fois son `.png`
  déposé ici, dans le MÊME commit. Tant que la capture manque, son « pourquoi »
  attend dans `## En attente de capture` (bloc commenté). Un gate déterministe
  (`scripts/check-exemplars.sh`, branché sur le Stop hook en session kit) refuse
  de finir si une ligne live n'a pas son fichier — ou si un `.png` n'a pas sa
  ligne. C'est ce gate qui empêche les exemplaires fantômes (annoncés, jamais
  capturés) de se reproduire.
- Alimentée par le rapport /retro (écrans shippés validés : capture + ligne
  d'index, portés en session kit) et par /da (références externes qui méritent
  de survivre à leur projet).
- Consultée en PREMIER par /da, avant Mobbin et le web.
- Curation : au-delà de ~20 lignes, regrouper l'index par domaine ; un
  exemplaire contredit par un retour de Baptiste se retire (l'index garde
  la trace, comme "On rejette" dans les pattern briefs).

## Index

<!-- live uniquement : - fichier.png — app/écran — pourquoi c'est bien (1 ligne) — domaine -->

<!-- Vide tant qu'aucun .png n'est déposé. Les « pourquoi » validés attendent
     dans ## En attente de capture ci-dessous ; dès qu'une capture arrive dans
     ce dossier, déplacer sa ligne ici, dans le MÊME commit. -->

## En attente de capture

<!-- « Pourquoi » validés mais .png pas encore déposé : ne comptent pas (gate).
     Dès que la capture arrive dans ce dossier, déplacer la ligne dans ## Index.

     Portfolio Baptiste (fintech, dark) — « pourquoi » validé en /retro 2026-06-13 :
     - portfolio-baptiste-home-dark.png — portfolio Baptiste / home (dark) — surfaces plates + filets 1px + métadonnées monospace (signature « fiche technique ») + accent petrol unique ; la retenue se lit comme de la précision, zéro déco — fintech
     - portfolio-baptiste-project-dark.png — portfolio Baptiste / fiche projet (dark) — même système (surfaces plates + filets + monospace + accent petrol), la fiche projet pousse la signature « fiche technique » ; précision = retenue — fintech

     Étalon du curseur d'audace (fintech) — ces trois apps BORNENT le levier
     showcase/bold ↔ produit/sobre câblé dans /da et skills/art-direction.
     Capturer via Mobbin EN LOCAL (auth interactive impossible en remote, cf.
     docs/wip-oeil-visuel.md), nommage fintech-<app>-<écran>.png, puis déposer
     les .png ici :
     - fintech-bnp-comptes.png — BNP Mes Comptes / comptes — borne BASSE du curseur : rassurer par la sobriété, hiérarchie portée par le solde en grand, densité maîtrisée, accent institutionnel unique, zéro geste risqué (confiance = convention, loi de Jakob) — fintech
     - fintech-qonto-dashboard.png — Qonto / dashboard — MILIEU du curseur : rigueur B2B, grille stricte, typo nette, données denses sans surcharge, montants `tabular-nums`, accent sobre ; retenue *habitée* — fintech
     - fintech-revolut-home.png — Revolut / home — borne HAUTE du curseur : parti-pris fort assumé, couleur/motion signature, cartes produit différenciées, reconnaissable logo masqué ; registre « postable sur Dribbble » — fintech
-->
