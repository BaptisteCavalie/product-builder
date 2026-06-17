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

## Mobbin (résolu en local le 2026-06-17)

- En local le serveur Mobbin se charge au démarrage et `/da` l'interroge
  normalement (`search_screens` renvoie images inline + `image_url`
  téléchargeable + `mobbin_url`). Le bloqueur remote est levé.
- **Limite de la bibliothèque Mobbin** : Revolut présent, mais **ni BNP ni Qonto**
  (apps FR/EU absentes, vérifié en recherche au nom exact, ios ET web). Conséquence
  sur l'étalon : Revolut capturé via Mobbin ; Qonto capturé depuis son **site
  public** (`qonto.com/en/product-tour`, Playwright via `capture-ref.sh`) qui
  montre le vrai dashboard ; BNP reste à fournir par Baptiste (capture perso).
- Récupération PNG : `curl` l'`image_url` (renvoie du WebP) puis `sips -s format
  png` pour un vrai PNG. Les previews MCP font ~300px de large (suffisant pour une
  référence de goût, pas du haute-résolution).

## Prochaines étapes (session relancée)

1. **[FAIT en partie — 2026-06-17]** Revolut (Mobbin) + Qonto
   (`qonto.com/en/product-tour`) capturés et **live** dans l'index.
   `fintech-bnp-comptes.png` reste **en attente** : Baptiste fournira la capture
   (BNP absent de Mobbin). Gate `check-exemplars.sh` ✓.
2. **[FAIT]** Les 3 lignes d'index sont écrites dans `references/README.md` avec
   les « pourquoi » du tableau (bornes basse/milieu/haute). Il ne manque que les
   `.png` (étape 1) pour que les exemplaires soient complets.
3. **[FAIT]** Curseur d'audace câblé dans `commands/da.md` (étape 3, décision
   explicite) et `skills/art-direction/SKILL.md` (section dédiée), les 3 apps
   nommées comme bornes. Gate `check-doctrine.sh` étendu pour le rendre auditable.
4. **[FAIT]** Sources `/da` amendées vers le hors-UI (éditorial, affiche, photo,
   type specimens) avec le pourquoi « les galeries UI sont incestueuses ».
5. **[FAIT]** `scripts/check-doctrine.sh` ✓ + `claude plugin validate` ✓ (warning
   « no version » attendu, cf. CLAUDE.md).
6. **[FAIT — 2026-06-17]** Base multi-domaines semée via Mobbin (12 exemplaires,
   16 live au total sur 13 domaines) : crypto (Kraken), saas (Linear), landing
   (Cursor), ai (ChatGPT, Pi), ecommerce (H&M PDP, Shop checkout), travel
   (Airbnb), food (Glovo), productivité (Things 3), fitness (Tonal), wellness
   (Calm), media (Spotify), booking (Cal.com). Chaque ligne porte un pattern + sa
   source. Volontairement ~2/domaine max (règle de curation : « dix moodboards =
   zéro direction »). RESTE pour vraiment élargir : du **hors-UI** (éditorial
   print, affiche, type specimens) — non couvert par Mobbin, à sourcer via /da.

> État au 2026-06-17 (session locale) : bibliothèque passée de 0 à 16 exemplaires
> live, groupés par domaine. Étalon fintech milieu+haute live (Qonto, Revolut),
> borne basse (BNP) + paire portfolio en attente côté Baptiste. Gates ✓.
