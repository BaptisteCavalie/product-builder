---
name: art-direction
description: "Le métier de visual designer senior — direction artistique, choix et appariement typographique, composition/grille, motion, et le jugement qui distingue le senior du junior. Déclencher pour établir OU évaluer le parti-pris visuel : /da, build d'UI, critique. Complète design-judgment (utilisabilité), color (palette) et anti-slop (interdits)."
---

# Direction artistique — le craft senior

design-judgment garantit qu'un écran est *utilisable* ; ce skill garantit
qu'il a une *intention*. C'est la couche générative du goût : ce qu'un visual
designer senior décide et, surtout, ce qu'il refuse.

## Le noyau (si tu ne retiens que 4 choses)

1. **Retire** l'ornement gratuit — mais **garde un geste fort** par écran.
2. La **typo est nommée** et porte l'ambiance ; 2 familles max.
3. La **motion explique** quelque chose, ou elle n'existe pas.
4. L'identité = **répétition** d'un petit nombre de partis-pris, pas accumulation.

## Ce qu'est la direction artistique

Le parti-pris visuel cohérent qui donne une émotion et une intention à
l'interface. Distincte du **branding** (qui définit *qui* est la marque) et de
l'**hygiène UX** (qui la rend *utilisable*) : l'AD répond à « à quoi ça
ressemble, et pourquoi cette émotion plutôt qu'une autre ». Elle vit dans
`design/da.md` et se juge sur la cohérence à travers tous les écrans, pas écran
par écran.

## La leçon de l'histoire : principe durable vs mode

Skeuomorphisme (Mac, Aqua) → flat (iOS 7, Metro) → Material (la profondeur
revient) → neumorphism → glass… Les styles oscillent tous les ~8 ans. Ce qui
ne bouge pas : **clarté, affordance appropriée, hiérarchie, respect des
conventions** (loi de Jakob). Le skeuomorphisme avait raison sur une chose
(rendre le neuf familier), tort sur le reste (l'ornement comme fin).
**Règle** : n'adopte un trait de style daté (glow, glass, gros gradients,
ombres portées partout) que s'il sert un principe durable nommé. Sinon c'est
une mode — tu la reconnaîtras dans 3 ans à la date. Justifie ou abstiens-toi.

**Ce que les grands systèmes ont durablement raison** — à distiller, jamais à
copier : leurs guidelines sont à ~80% de la conformité plateforme (tailles de
cibles, composants natifs), pas du goût. On prend le principe, on laisse la peau.
- **HIG (Apple) — la déférence.** Le chrome s'efface devant le contenu (clarté
  > déférence > profondeur). C'est la colonne vertébrale de la retenue senior
  ci-dessous, posée dès iOS 7. *Piège* : reprendre les composants natifs iOS
  (barres système, switches, SF Symbols) sur le web → un écran qui ressemble à
  un iPhone, pas à ton produit.
- **Material (Google) — profondeur et motion portent du sens.** L'élévation
  encode la hiérarchie et l'état (ce qui flotte est actif ou temporaire) ; la
  transition d'élément partagé montre origine → destination (déjà dans
  « Composition » et « Motion » plus bas). *Piège* : les valeurs dp, le FAB, le
  ripple, l'accent indigo par défaut = look Android générique.
- **Le fil commun, 40 ans** : un système cohérent (grille, échelle, tokens) bat
  des écrans décidés un par un. C'est exactement pourquoi le kit a des tokens.

**Garde-fou** : appliquer ces principes ne veut JAMAIS dire ressembler à iOS ou
Material — c'est l'interchangeable que combat le test du logo masqué. Le
principe est universel ; sa matérialisation reste celle du DA brief.

## Le réflexe senior : la retenue

Le junior **ajoute** jusqu'à ce que ça « fasse design » ; le senior **retire**
jusqu'à ce qu'il ne reste que l'intentionnel. Le jugement senior n'est pas
« c'est joli » mais « ça fait échouer l'utilisateur à l'étape 3, voici
pourquoi » — décision stratégique, pas décorative. Deux tests, à chaque écran :
1. **Test du retrait** : puis-je enlever cet élément (ombre, bordure, icône,
   couleur, trait) sans perte de sens ? Si oui → enlève-le.
2. **Test de l'intention** : puis-je nommer en une phrase pourquoi cet ornement
   existe ? Si non → c'est du réflexe statistique, pas une décision.

**La retenue n'est pas la timidité.** Une fois l'ornement gratuit retiré,
GARDE — ou gagne — **un geste fort assumé par écran** : l'élément signature du
DA brief (typo géante, couleur tranchée, composition osée). Un écran sans aucun
parti-pris a échoué autant qu'un écran surchargé — c'est le SaaS beige, l'autre
slop. Le test du retrait ne s'applique JAMAIS à l'élément signature : son
intention *est* l'identité.

## Le curseur d'audace : doser le geste

La retenue dit de garder UN geste fort ; le curseur dit **jusqu'où le pousser**.
C'est un lever explicite **showcase/bold ↔ produit/sobre**, tranché en `/da` et
écrit dans le DA brief — une *décision*, pas un défaut. Ni borne n'est « mieux » :
le slop guette aux deux bouts (surchargé d'un côté, correct-mais-mort de l'autre).
Ce qui le règle vient de l'étape 1 du brief : qui utilise le produit, dans quel
état d'esprit, et la convention du domaine (loi de Jakob — un domaine méfiant
récompense la convention, pas l'audace).

Trois exemplaires fintech le **calibrent** (bibliothèque
`design-system/references/`, à regarder côte à côte) :
- **Basse — BNP.** Rassurer par la convention : hiérarchie portée par une donnée
  en grand, accent institutionnel unique, zéro geste risqué. L'audace serait une
  faute (l'argent veut de la confiance).
- **Milieu — Qonto.** Retenue *habitée* : grille stricte, typo nette, densité
  maîtrisée, accent sobre mais présent. Le défaut senior pour un outil quotidien.
- **Haute — Revolut.** Parti-pris signature assumé : couleur/motion tranchées,
  reconnaissable logo masqué, « postable sur Dribbble ». Réservé aux produits qui
  doivent séduire avant de rassurer.

Conséquence opérationnelle : plus le curseur monte, plus l'élément signature est
amplifié — et plus le sourcing doit sortir de la discipline (un geste fort se
vole hors-UI : éditorial, affiche, photo ; cf. `/da` étape 2). Calibrer trop
étroit est un risque connu : ces trois bornes sont fintech, un brief d'un autre
monde se calibre sur ses propres exemplaires.

## Typographie : choisir et apparier

(design-judgment tient l'hygiène — tailles, longueur de ligne, graisses ; ici
c'est l'expression.)
- **Nomme la police.** « Sans-serif système » par défaut n'est pas un choix.
  La typo porte ~80% de l'ambiance pour 0 coût de layout — c'est le levier de
  goût le moins cher.
- **2 familles max.** Le plus sûr : une famille, deux graisses (corps regular,
  titre bold). Pour du caractère : serif expressif en titre + sans lisible en
  corps.
- **Apparie sur la x-height.** Deux polices à x-height proche s'équilibrent ;
  un grand écart fait paraître le corps trop petit ou trop gros. Cherche le
  contraste de structure (serif/sans, étroit/large), pas de hauteur.
- **Échelle modulaire, pas de tailles au hasard.** Un ratio unique : Quarte
  (1.333) par défaut web, Tierce mineure (1.2) pour le dense. Déjà dans les
  tokens — respecte l'échelle.
- **Chiffres comparés = `tabular-nums`** (montants, stats, tableaux) pour
  qu'ils s'alignent en colonnes.

## Composition & grille

- **Grille 8pt.** Marges, gouttières, colonnes, tailles : multiples de 8 (4
  pour les micro-ajustements). C'est le système d'espacement des tokens étendu
  à la mise en page — un écran sur la grille « sonne juste » sans qu'on sache
  pourquoi.
- **Espace interne ≤ espace externe.** Un élément est plus proche de son
  groupe que du voisin (renforce la proximité Gestalt de design-judgment).
- **Rythme vertical.** Aligne sur une baseline cohérente ; l'espace blanc crée
  la musique, il ne se « remplit » pas.
- **Équilibre du poids visuel.** Chaque écran a un centre de gravité. Le
  déséquilibre est soit un message assumé (asymétrie dirigée), soit une erreur
  — jamais un hasard.
- **Proportion.** Rapports image/bloc, large/étroit : sers-toi d'un ratio
  (1.5, nombre d'or) plutôt que de l'arbitraire.

## Motion : intention et exécution

- **Durées.** Micro-interactions (hover, toggle, press) 100–200 ms ;
  transitions de vue/contexte 200–500 ms. La durée croît avec la distance
  parcourue ou le changement de taille (Material, Carbon).
- **Easing.** `ease-out` à l'entrée (arrive vite, se pose), `ease-in` à la
  sortie (part vite). Jamais `linear` pour de l'UI — ça paraît mécanique.
- **Intention.** La motion sert la compréhension (montrer origine/destination,
  continuité, feedback) ou elle n'existe pas. Zéro animation décorative sur
  chaque élément. Une seule question : qu'est-ce que ce mouvement *explique* ?
- **`prefers-reduced-motion`** : toujours une alternative sans mouvement.

## Cohérence = signature

L'identité naît de la **répétition disciplinée** d'un petit nombre de partis-
pris (l'élément signature du DA brief), pas de l'accumulation d'idées neuves.
Un même problème se résout de la même façon partout. Test final, logo masqué :
l'écran est-il reconnaissable ? Reconnaissable = AD réussie ; interchangeable
= retour au DA brief.
