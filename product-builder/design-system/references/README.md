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

<!-- live uniquement : - fichier.png — app/écran — pourquoi c'est bien (1 ligne) — domaine — source -->

<!-- Étalon du curseur d'audace (fintech) — bornent le levier showcase/bold ↔
     produit/sobre câblé dans /da et skills/art-direction. Borne BASSE (BNP)
     encore en attente de capture ci-dessous ; milieu + haute live. -->
- fintech-qonto-dashboard.png — Qonto / dashboard (product-tour) — MILIEU du curseur : rigueur B2B, grille stricte, typo nette, transactions denses sans surcharge, montants `tabular-nums`, accent sobre ; retenue *habitée* — fintech — source : https://qonto.com/en/product-tour
- fintech-revolut-home.png — Revolut / home — borne HAUTE du curseur : parti-pris fort assumé, cartes produit différenciées (couleur signature), reconnaissable logo masqué ; registre « postable sur Dribbble » — fintech — source : https://mobbin.com/screens/8e9b49d9-6451-481a-bf05-06960c346197

<!-- Hors-fintech — élargissent l'œil au-delà de l'étalon fintech, pour ne pas
     calibrer le curseur trop étroit (cf. docs/wip-oeil-visuel.md). -->
- saas-linear-issues.png — Linear / liste d'issues (web) — densité comme signature : dark monochrome + 1 accent, typo nette, lignes denses sans surcharge, hints clavier ; la retenue rend premium, pas mort — saas/devtools — source : https://mobbin.com/screens/cc5d476b-5ba1-4bc2-bcf3-d6dcc9a636a3
- travel-airbnb-explore.png — Airbnb / explore (iOS) — éditorial photo-led chaleureux : la photographie en héros, cartes arrondies généreuses, blanc abondant, micro-copie amicale ; le contre-pied exact de la rigueur fintech — travel/éditorial — source : https://mobbin.com/screens/97fb6459-9591-43df-8142-dcc1fd99c04c

## En attente de capture

<!-- « Pourquoi » validés mais .png pas encore déposé : ne comptent pas (gate).
     Dès que la capture arrive dans ce dossier, déplacer la ligne dans ## Index.

     Borne BASSE du curseur (fintech) — Baptiste fournira la capture lui-même
     (BNP absent de Mobbin ; institutionnel français sobre dur à substituer) :
     - fintech-bnp-comptes.png — BNP Mes Comptes / comptes — borne BASSE du curseur : rassurer par la sobriété, hiérarchie portée par le solde en grand, densité maîtrisée, accent institutionnel unique, zéro geste risqué (confiance = convention, loi de Jakob) — fintech

     Portfolio Baptiste (fintech, dark) — « pourquoi » validé en /retro 2026-06-13 :
     - portfolio-baptiste-home-dark.png — portfolio Baptiste / home (dark) — surfaces plates + filets 1px + métadonnées monospace (signature « fiche technique ») + accent petrol unique ; la retenue se lit comme de la précision, zéro déco — fintech
     - portfolio-baptiste-project-dark.png — portfolio Baptiste / fiche projet (dark) — même système (surfaces plates + filets + monospace + accent petrol), la fiche projet pousse la signature « fiche technique » ; précision = retenue — fintech
-->
