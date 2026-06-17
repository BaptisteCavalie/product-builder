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

<!-- Groupé par domaine (règle de curation). SEUL le trio fintech calibre le
     curseur d'audace (bornes basse/milieu/haute, câblé dans /da et
     skills/art-direction) ; les autres domaines sont des exemplaires de
     registre/pattern, pas des bornes. Captures via Mobbin (image_url → PNG) sauf
     mention ; previews ~300px iOS / ~768px web. -->

### Fintech
<!-- Étalon du curseur d'audace : Qonto (milieu) + Revolut (haute) live ;
     borne BASSE (BNP) en attente de capture ci-dessous. -->
- fintech-qonto-dashboard.png — Qonto / dashboard (product-tour) — MILIEU du curseur : rigueur B2B, grille stricte, typo nette, transactions denses sans surcharge, montants `tabular-nums`, accent sobre ; retenue *habitée* — fintech — source : https://qonto.com/en/product-tour
- fintech-revolut-home.png — Revolut / home — borne HAUTE du curseur : parti-pris fort assumé, cartes produit différenciées (couleur signature), reconnaissable logo masqué ; « postable sur Dribbble » — fintech — source : https://mobbin.com/screens/8e9b49d9-6451-481a-bf05-06960c346197

### Crypto
- crypto-kraken-portfolio.png — Kraken / portfolio (iOS) — market list scannable : sparkline + delta vert/rouge par ligne, valeur totale en grand puis courbe, lavande de marque qui évite le dark générique ; dense mais lisible — crypto — source : https://mobbin.com/screens/f74e0d00-bd13-402a-8656-fdbb624a6a57

### SaaS / outils
- saas-linear-issues.png — Linear / liste d'issues (web) — densité comme signature : dark monochrome + 1 accent, typo nette, lignes denses sans surcharge, hints clavier ; la retenue rend premium, pas mort — saas — source : https://mobbin.com/screens/cc5d476b-5ba1-4bc2-bcf3-d6dcc9a636a3

### Landing / marketing
- landing-cursor-hero.png — Cursor / landing hero (web) — landing premium retenue : headline confiante alignée à gauche, UN seul CTA sombre, gros screenshot produit posé sur dégradé doux ; le produit *est* le visuel — landing — source : https://mobbin.com/screens/fe74d042-38df-4046-9bef-65533403e2d7

### AI
- ai-chatgpt-composer.png — ChatGPT 4o / chat (web) — le standard du composer IA : « Ask anything », chips d'action (Search / Deep research / Create image), switch de modèle, sidebar projets ; clarté avant tout — ai — source : https://mobbin.com/screens/3a13706c-8391-4bd4-8984-0bac68cc412a
- ai-pi-chat.png — Pi / chat (web) — l'IA à personnalité : fond crème chaud, type humaine, bulles douces, ton conversationnel ; comment échapper au look ChatGPT générique — ai — source : https://mobbin.com/screens/a7d703a9-576c-47a8-acac-7f8de552a53b

### E-commerce
- ecommerce-hm-pdp.png — H&M / fiche produit (iOS) — PDP modèle : couleur (vignettes) → taille (grille, état sélectionné net) → CTA primaire plein → fulfillment magasin ; hiérarchie d'achat sobre — ecommerce — source : https://mobbin.com/screens/b73006c6-61de-4440-922f-3aacbf556df6
- ecommerce-shop-checkout.png — Shop / Review & Pay (iOS) — checkout qui rassure : récap clair, frais détaillés (sous-total / livraison / taxes), montant SUR le bouton « Pay now », upsell discret ; zéro friction cachée — ecommerce — source : https://mobbin.com/screens/3079dcae-8672-4fda-83d3-40ed4c8345bf

### Travel
- travel-airbnb-explore.png — Airbnb / explore (iOS) — éditorial photo-led chaleureux : la photographie en héros, cartes arrondies généreuses, blanc abondant, micro-copie amicale ; le contre-pied de la rigueur fintech — travel — source : https://mobbin.com/screens/97fb6459-9591-43df-8142-dcc1fd99c04c

### Food delivery
- food-glovo-discovery.png — Glovo / découverte (iOS) — feed appétissant : grande photo qui vend, cartes scannables (match %, prix barré, délai) ; la décision tient dans une carte — food — source : https://mobbin.com/screens/1843d128-db24-4471-b132-47634c8a15ac

### Productivité
- productivity-things-today.png — Things 3 / Today (iOS) — to-do typographique : hiérarchie douce (Today / This Evening), espacement généreux, tags discrets, zéro chrome inutile ; le calme comme craft — productivité — source : https://mobbin.com/screens/724087de-2e95-47ec-926c-efbdab249a23

### Fitness
- fitness-tonal-target.png — Tonal / target (iOS) — métrique-héros : UN chiffre dans un grand anneau de progression, « WEEKLY TARGET EXCEEDED » en récompense, reste secondaire ; motiver = célébrer une donnée — fitness — source : https://mobbin.com/screens/5e9461c9-d902-4e37-ad82-906753bc7583

### Wellness
- wellness-calm-meditate.png — Calm / meditate (iOS) — registre serein : photographie nature plein cadre, dégradé bleu nuit, type douce, peu d'éléments ; le calme se *montre*, ne se décrit pas — wellness — source : https://mobbin.com/screens/0a477316-3bc1-490f-a3d8-e87ad22cd978

### Media / musique
- media-spotify-nowplaying.png — Spotify / now playing (iOS) — lecture immersive : pochette en héros, fond teinté par la couleur ambiante extraite de l'artwork, contrôles minimaux sur sombre ; l'écran s'efface devant le contenu — media — source : https://mobbin.com/screens/43a707cc-5c25-4bc8-8f7a-f24852d1f59b

### Booking / scheduling
- booking-calcom-scheduling.png — Cal.com / scheduling (web) — réservation lisible : 3 volets (qui / quelle date / quel créneau), calendrier net, créneau sélectionné mis en évidence, dark élégant ; un flux en une vue — booking — source : https://mobbin.com/screens/0a64d12e-0306-461a-8365-f7869cbb4efb

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
