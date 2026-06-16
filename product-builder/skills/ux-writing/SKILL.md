---
name: ux-writing
description: "Le métier de content designer / UX writer senior — voix & ton, microcopy (boutons, erreurs, empty states, confirmations), clarté, concision et cohérence terminologique. Déclencher dès qu'on écrit un mot visible par l'utilisateur : label, message, titre, placeholder, notification, email — pas seulement quand l'utilisateur dit « copy ». Complète design-judgment (les 5 états), anti-slop (le plancher verbal) et domain-knowledge (terminologie du domaine)."
---

# UX writing — les mots sont de l'interface

Un mot dans l'UI est un composant : il oriente, rassure ou égare autant qu'un
bouton mal placé. `anti-slop` tient le plancher verbal (ce qu'on n'écrit
jamais) ; ce skill tient le plafond — le mot juste, choisi. design-judgment dit
qu'un état error « dit quoi faire » ; ici on dit *comment l'écrire*. On écrit la
microcopy AVANT de styler : souvent elle rend l'écran évident et économise un
composant.

## Le noyau (si tu ne retiens que 4 choses)

1. **Écris l'action, pas le mécanisme** : « Créer mon compte », jamais « Soumettre ».
2. **Une voix constante, un ton qui s'adapte** au moment (erreur ≠ célébration).
3. **Un concept = un mot**, partout. La synonymie est un bug d'UX.
4. **Coupe la moitié** : le premier jet a toujours trop de mots.

## Voix & ton — un seul « vous », plusieurs humeurs

La **voix** est constante : la personnalité verbale du produit, dérivée des
mots d'ambiance du DA brief (`design/da.md`) et du domaine. Le **ton** flexe
selon le moment : posé sur une erreur, sobre sur une confirmation, discret
partout ailleurs. Nomme la voix en 3 adjectifs (ex. « direct, humain, jamais
corporate ») — sinon chaque écran retombe sur le ton moyen : neutre-FAQ.
- Parle À l'utilisateur (« tu »/« vous »), pas DE lui. Le choix tu/vous se
  tranche une fois et se tient partout.
- Voix active, sujet humain : « Tu n'as pas encore de projet », pas « Aucun
  projet n'a été trouvé » (la machine se cache, pas l'utilisateur).

## Clarté avant tout

- **Le mot le plus simple gagne.** Préfère le concret au corporate ; bannis le
  jargon technique exposé (codes bruts, « token expiré », « null ») sauf public
  dev assumé.
- **Concision.** « afin de » → « pour », « est en mesure de » → « peut ». Coupe
  les mots de remplissage : un label qui tient en 2 mots n'en prend pas 6.
- **Front-loading.** L'info porteuse en tête de phrase ou de label — on scanne
  l'UI, on ne la lit pas (loi de lecture en F).
- **Une idée par phrase.** Si une consigne a deux conditions, fais-en deux
  phrases ou une liste.

## Les surfaces qui comptent (microcopy)

- **Boutons & labels** : verbe + objet ; 1re personne quand c'est un engagement
  (« Créer mon compte »). Le label dit ce qui se passe au clic, pas la mécanique.
- **Messages d'erreur** : (1) ce qui s'est passé en clair, (2) quoi faire
  maintenant, (3) sans culpabiliser ni « Oops ». Ex. « Carte refusée — vérifie
  le numéro ou essaie une autre carte. »
- **Empty states** : jamais « Aucune donnée ». Dis ce qui apparaîtra ici + une
  action pour le remplir — c'est de l'onboarding déguisé (soigne ce moment,
  peak-end).
- **Confirmations / succès** : sobre et spécifique (« Facture envoyée à
  marie@… »), pas « Succès ! ». L'exclamation est réservée aux vraies
  célébrations (max 1, cf. anti-slop).
- **Placeholders ≠ labels.** Le placeholder est un exemple, jamais le seul
  label : il disparaît à la saisie (perte d'info + problème a11y). Label
  toujours visible.
- **Actions destructives** : nomme la conséquence dans le bouton (« Supprimer
  le projet »), pas « OK » ; la confirmation répète quoi et que c'est
  irréversible.

## Terminologie : un concept, un mot

- Un même objet porte le même nom partout : pas « dossier » ici, « projet » là.
- Aligne le vocabulaire sur le domaine (charge `domain-knowledge`) et sur le
  langage des utilisateurs, jamais sur les noms du modèle de données interne.
- Vocabulaire dense → tiens un mini-glossaire dans le projet. La cohérence
  terminologique est invisible quand elle est bonne, criante quand elle manque.

## Chiffres, dates, formats

- Dates relatives quand c'est proche (« il y a 3 min », « hier »), absolues
  au-delà — jamais un timestamp brut.
- Montants : devise explicite, séparateurs locaux, `tabular-nums` (cf.
  art-direction). Pas de « 1000000 ».
- Pluriels gérés (« 1 élément » / « 3 éléments »), jamais « 1 élément(s) ».

## FR / EN : pas de calque

- N'écris pas un français traduit de l'anglais : pas de Title Case sur les
  titres FR, pas de « Editer ». Ponctuation française (espace insécable avant
  `: ; ! ?`).
- Si bilingue : même voix dans les deux langues, pas une traduction littérale.

## La leçon du métier

Le content design s'est constitué en discipline (NN/g, voice&tone Mailchimp,
contenu Polaris/Shopify, Podmajersky *Strategic Writing for UX*) autour d'une
idée durable : **le contenu n'habille pas l'UI après coup, il EST l'UI.** À
retenir, pas les chartes maison de chacun.

## Le test final — trois questions

1. **Lecture à voix haute** : ça sonne comme un humain qui aide, ou comme un
   formulaire administratif ? Si admin → réécris.
2. **Test de la moitié** : puis-je dire la même chose en deux fois moins de
   mots sans perdre de sens ? Si oui → coupe.
3. **Test du mécanisme** : un label ou message décrit-il la plomberie technique
   plutôt que l'intention de l'utilisateur ? Si oui → traduis en intention.
