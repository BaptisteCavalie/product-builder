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
- **Provenance du goût — proposé vs validé.** Un exemplaire entré par *sourcing*
  (/da ou un agent) est **proposé** tant que Baptiste ne l'a pas validé à l'œil ;
  un écran qu'il a approuvé en /retro entre **validé**. /da peut s'appuyer sur des
  « proposés » mais doit le **signaler** dans son rapport (il s'ancre sur des
  candidats, pas sur du goût gravé). La validation à l'œil promeut proposé →
  validé. Le statut courant de chaque exemplaire est marqué dans `## Index`.
- **Résolution.** Préfère une capture haute-déf via `scripts/capture-ref.sh` quand
  l'écran est sur une page publique (landing, page produit type Qonto product-tour) ;
  sinon accepte la preview Mobbin (~300px iOS / ~768px web) et note-le. Une preview
  basse-déf ancre un registre/pattern, pas le micro-craft (filet 1px, calage typo) —
  ne pas s'y fier pour juger la précision.
- Curation : au-delà de ~20 lignes, regrouper l'index par domaine ; un
  exemplaire contredit par un retour de Baptiste se retire (l'index garde
  la trace, comme "On rejette" dans les pattern briefs).

## Index

<!-- live uniquement : - fichier.png — app/écran — pourquoi c'est bien (1 ligne) — domaine — source -->

<!-- STATUT (2026-06-17) : les 8 ci-dessous sont PROPOSÉS — sourcés et alignés sur
     le goût DÉCLARÉ de Baptiste, mais pas encore validés à l'œil un par un. À sa
     relecture, les survivants passent « validé » ; les recalés se retirent.
     Curé sur le goût déclaré : penchant sharp/technique
     + calme/minimal, distinctif > canonique, domaines data + outils. Les picks
     « lifestyle » et « transaction » et les AI canoniques (ChatGPT, Pi) ont été
     retirés à ce titre. SEUL le trio fintech calibre le curseur d'audace (bornes
     basse/milieu/haute, câblé dans /da et skills/art-direction) ; le reste = des
     exemplaires de registre/pattern. Résolution : 1440px pour les sites publics
     (Qonto product-tour, Cursor), 768px web (Linear, Fey, Perplexity), 300px
     pour les écrans d'app mobiles (Revolut, Kraken, Things — non recapturables
     hors device). -->

### Fintech — étalon du curseur d'audace
<!-- Qonto (milieu) + Revolut (haute) live ; borne BASSE (BNP) en attente ci-dessous.
     Revolut est gardé pour son RÔLE de borne haute (structurel), pas par penchant —
     le « bold » n'est pas le goût déclaré de Baptiste. -->
- fintech-qonto-dashboard.png — Qonto / dashboard (product-tour) — MILIEU du curseur : rigueur B2B, grille stricte, typo nette, transactions denses sans surcharge, montants `tabular-nums`, accent sobre ; retenue *habitée* — fintech — source : https://qonto.com/en/product-tour
- fintech-revolut-home.png — Revolut / home — borne HAUTE du curseur : parti-pris fort assumé, cartes produit différenciées (couleur signature), reconnaissable logo masqué ; « postable sur Dribbble » — fintech — source : https://mobbin.com/screens/8e9b49d9-6451-481a-bf05-06960c346197

### Crypto / data
- crypto-kraken-portfolio.png — Kraken / portfolio (iOS) — market list scannable : sparkline + delta vert/rouge par ligne, valeur totale en grand puis courbe, lavande de marque qui évite le dark générique ; dense mais lisible — crypto — source : https://mobbin.com/screens/f74e0d00-bd13-402a-8656-fdbb624a6a57
- data-fey-command.png — Fey / palette de commandes (web) — vitesse comme signature : recherche d'actions au clavier sur une watchlist, dark dense, raccourci-lettre par ligne ; sharp et distinctif, pile le penchant technique — data/investing — source : https://mobbin.com/screens/ff52ac90-4d18-4765-98da-df1e362a5ee1

### SaaS / outils
- saas-linear-issues.png — Linear / liste d'issues (web) — densité comme signature : dark monochrome + 1 accent, typo nette, lignes denses sans surcharge, hints clavier ; la retenue rend premium, pas mort — saas — source : https://mobbin.com/screens/cc5d476b-5ba1-4bc2-bcf3-d6dcc9a636a3

### AI
- ai-perplexity-answer.png — Perplexity / réponse (web) — answer engine clair : réponse structurée en sections, sources citées numérotées, follow-up en bas ; densité d'info maîtrisée, registre calme/sobre — ai — source : https://mobbin.com/screens/fbb88ccb-591d-4fca-a6a7-6f5cd3311db6

### Landing / marketing
- landing-cursor-hero.png — Cursor / landing (cursor.com, capture 1440) — landing premium retenue : headline confiante alignée à gauche, UN seul CTA sombre, gros screenshot produit sur dégradé doux ; le produit *est* le visuel — landing — source : https://cursor.com

### Productivité — ancrage calme/minimal
- productivity-things-today.png — Things 3 / Today (iOS) — to-do typographique : hiérarchie douce (Today / This Evening), espacement généreux, tags discrets, zéro chrome inutile ; le calme comme craft — productivité — source : https://mobbin.com/screens/724087de-2e95-47ec-926c-efbdab249a23

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
