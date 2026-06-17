# WIP — Améliorer l'œil visuel du kit (autonomie de veille + étalon de goût)

> Trace de session à reprendre. Ce n'est pas une doctrine appliquée : c'est un
> état des lieux + plan, à porter dans les fichiers du kit lors d'une session
> relancée (notamment une où le MCP Mobbin est chargé et authentifié).
> Date d'écriture : 2026-06-17.

## Diagnostic

Le kit a un **œil critique** très solide (anti-slop : 50+ interdits, design-critic :
9 rubriques binaires, doctrine couleur OKLCH précise) mais pas d'**œil génératif**
nourri. Un œil se forme par comparaison à de **bons exemplaires**, pas par lecture
de règles. Or `design-system/references/` est **vide** (README + 2 lignes d'index en
commentaire, aucun PNG). Tout le système suppose pourtant cette bibliothèque :
`/da` la consulte en premier, `design-critic` compare « côte à côte », `/retro`
est censé l'alimenter.

Le **process est déjà câblé** (pipeline `/feature`, `/da`, critics, boucle de
correction, `/retro`). Ce qui manque est ~80% des **références**, + 2 petits
réglages de doctrine.

## Critère de réussite retenu

« Postable sur Dribbble sans se faire insulter. » Deux façons de rater :
1. **Slop visible** (violet/glass/orbs, type mal calé, card-in-card…) → le kit sait
   déjà l'éviter (anti-slop).
2. **Correct-mais-mort** (propre, accessible, oubliable) → le kit y plafonne, car sa
   doctrine pousse la *retenue*. Dribbble récompense le **geste signature**, pas
   l'absence de faute.

## Décisions

1. **Remplir la bibliothèque d'exemplaires** = priorité n°1. C'est l'étalon qui
   permet au kit de s'auto-juger sans checkpoint humain → débloque l'autonomie de
   veille. Sans étalon, l'inspiration autonome régresse vers le trend = slop.
2. **Curseur d'audace** à câbler dans `/da` et `skills/art-direction` : un lever
   explicite showcase/bold ↔ produit/sobre. Les références ne le règlent pas seules
   (c'est une *décision*, pas un exemple).
3. **Sourcing hors-UI** : amender la liste de sources de `/da` (trop incestueuse :
   Dribbble/Awwwards/Godly) pour pousser vers l'adjacent (éditorial print, photo,
   affiche, type specimens). Un geste signature fort se vole hors de la discipline.
4. **Dépôt automatique** : chaque run autonome qui produit un bon écran redépose ses
   meilleures références dans la bibliothèque (déjà prévu côté `/retro`, à renforcer).

## Exemplaires fournis par Baptiste (fintech) — à capturer puis annoter

Ils dessinent directement le curseur d'audace :

| Référence | Registre | Pourquoi (annotation index) | Curseur |
|---|---|---|---|
| **BNP Mes Comptes** | Finance grand public, clean | Rassurer par la sobriété : hiérarchie portée par le solde en grand, densité maîtrisée, accent institutionnel unique, zéro geste risqué (confiance = convention, loi de Jakob). | Borne **basse** |
| **Qonto** | Pro, propre, clean | Rigueur B2B : grille stricte, typo nette, données denses sans surcharge, montants `tabular-nums`, accent sobre. Retenue *habitée*. | **Milieu** |
| **Revolut** | Signature, bold, moderne | Parti-pris fort assumé : couleur/motion signature, cartes produit différenciées, reconnaissable logo masqué. Registre « postable sur Dribbble ». | Borne **haute** |

## Caution

L'étalon proposé est 100% fintech (et même Revolut est « bold *dans* la fintech »).
Risque : calibrer l'œil trop étroit → le kit ferait ressembler un brief non-fintech
(ex. « tool de photographie ») à une néobanque. À terme, ajouter 2-3 exemplaires
d'autres mondes (éditorial, photo, SaaS créatif).

## Bloqueur Mobbin (environnement)

- `claude mcp add mobbin --scope user --transport http https://api.mobbin.com/mcp`
  exécuté → ajouté à `/root/.claude.json`.
- Statut : **`Needs authentication`** (OAuth interactif, lié au compte Mobbin).
- Non utilisable depuis cette session remote : (a) les serveurs MCP se chargent au
  **démarrage** de session (pas à chaud) ; (b) l'auth interactive ne passe pas en
  headless.
- **Chemin qui marche : poste local.** Au prochain lancement de `claude`, le serveur
  se charge, auth une fois, puis `/da` interroge Mobbin normalement. Capturer
  BNP/Qonto/Revolut, déposer les PNG dans `design-system/references/`.

## Prochaines étapes (session relancée)

1. Capturer BNP/Qonto/Revolut via Mobbin (en local, authentifié) → PNG dans
   `product-builder/design-system/references/` (nommage `fintech-<app>-<écran>.png`).
2. Écrire les 3 lignes d'index avec les « pourquoi » du tableau ci-dessus.
3. Câbler le curseur d'audace dans `commands/da.md` et `skills/art-direction/SKILL.md`,
   en nommant ces 3 apps comme bornes de calibration.
4. Amender la liste de sources de `/da` vers le hors-UI.
5. Vérifier alignement doctrine (`scripts/check-doctrine.sh`) + `claude plugin validate`.
6. Plus tard : exemplaires hors-fintech pour élargir l'œil.
