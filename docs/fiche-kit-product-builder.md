# Fiche projet — Product Builder Kit

**Période :** 10 → 16 juin 2026 (1 semaine) · **Statut :** en production (chaque push = mise à jour distribuée aux projets) · **Auteur :** Baptiste Cavalié

---

## 1. En une phrase

Un **kit de construction de produits piloté par IA** : il encode la direction
artistique, le jugement design senior et un pipeline qualité, puis les injecte
automatiquement dans chaque projet qui le consomme — pour que des écrans
générés par IA soient *utilisables, accessibles, et non interchangeables*, sans
designer senior derrière chaque PR.

C'est un **multiplicateur de force**, pas une dépense ponctuelle : développé une
fois, il s'applique à tous les projets, et s'améliore en continu via les
retours terrain (`/retro`).

---

## 2. Ce que contient le kit (chiffres réels du repo)

| Brique | Quantité | Rôle |
|---|---|---|
| **Commandes** (pipelines) | 4 | `/feature` (build complet), `/da` (direction artistique), `/critique`, `/retro` |
| **Agents critics** | 4 | challenge produit, recherche de patterns, critique design senior, revue de code |
| **Skills** (connaissance) | 7 | jugement design, direction artistique, couleur (OKLCH), UX writing, anti-slop, accessibilité, métier |
| **Hooks** (gates déterministes) | 4 | injection de la constitution, vérifs automatiques |
| **Volume** | ~2 660 lignes | doctrine, pipelines, contrats de tokens |
| **Activité** | 19 commits | +3 079 / −415 lignes sur la semaine |

Architecture : une **constitution** (valeurs non négociables, injectée à chaque
session), des **pipelines** écrits noir sur blanc, des **critics** au jugement
isolé, une **bibliothèque d'exemplaires** (le goût validé, en images annotées),
et un **contrat de tokens** garantissant la cohérence visuelle.

---

## 3. Bénéfices

- **Qualité plancher garantie.** Accessibilité WCAG 2.2 AA, états complets
  (vide/chargement/erreur), zéro valeur visuelle hors design system — vérifiés
  automatiquement, pas « si on y pense ».
- **Anti-uniformité.** Le kit combat activement le « slop IA » (le SaaS beige,
  l'app violette générique) : test du logo masqué, geste signature obligatoire.
- **Le jugement senior, scalé.** Le critique design senior — habituellement une
  ressource rare et chère — tourne sur chaque écran, à coût marginal nul.
- **Cohérence multi-projets.** Une seule source de doctrine, distribuée. Un
  correctif de goût profite instantanément à tous les projets.
- **Capitalisation.** Chaque session laisse une trace (`/retro`) qui amende le
  kit : il s'améliore au lieu de répéter les mêmes erreurs.

---

## 4. Temps gagné (estimations indicatives, par tâche)

| Tâche | Sans le kit | Avec le kit | Gain |
|---|---|---|---|
| Établir une direction artistique cohérente | 0,5–1 j (designer) | 15–30 min (`/da`, checkpoint humain) | ~85 % |
| Construire une feature UI propre (hygiène + a11y + états + 5 critics) | 1–2 j | quelques heures | ~60–70 % |
| Critique design senior d'un écran | 1–2 h (ressource rare) | automatique, à la demande | ~100 % |
| Garantir la cohérence visuelle entre 5 projets | non scalable / erratique | structurel | qualitatif |
| Onboarding d'un nouveau projet sur les standards | 1+ j | session de démarrage | ~80 % |

**Lecture :** sur ~10 features livrées, l'ordre de grandeur du temps épargné se
chiffre en **dizaines d'heures de travail senior** (design + dev), tout en
relevant le plancher de qualité.

---

## 5. Coût en tokens de la conception

> Méthodologie : le développement d'un kit est un travail *agentique*
> (lecture répétée du repo, édition, validation, boucles de critique, brouillons
> jetés). Le coût réel dépasse largement la taille de l'artefact final
> (~2 660 lignes ≈ 30 k tokens). L'estimation ci-dessous est un **ordre de
> grandeur**, pas une facture exacte.

**Tarif (Claude Opus 4.8) :** 5 $/M tokens en entrée · 25 $/M en sortie ·
lecture de cache ~0,50 $/M (×0,1) · écriture de cache ~6,25 $/M.

| Poste | Estimation semaine |
|---|---|
| Tokens cumulés traités | ~5 à 15 M (dominés par l'entrée, fortement mise en cache) |
| Coût estimé (avec prompt caching) | **~30 à 90 $** |
| Équivalent | le coût de 1–2 heures d'un ingénieur |

Le **prompt caching** est décisif : la majorité du contexte (le repo relu à
chaque tour) est facturée à ~0,1× du tarif d'entrée. Sans cache, la même charge
coûterait plusieurs fois plus.

**Le point clé pour la direction :** même la borne haute (~90 $) est
*négligeable* face aux dizaines d'heures de travail senior que le kit fait
gagner — et ce coût est **non récurrent** (conception), alors que le gain est
**récurrent** (chaque feature, chaque projet, à perpétuité). Le ROI se mesure en
ordres de grandeur.

---

## 6. Évolutions possibles

- **Élargir la connaissance métier** : références par domaine (fintech, santé,
  e-commerce…) au-delà de l'existant.
- **Distillation continue** des principes durables des grands systèmes (HIG,
  Material) — principes, jamais conformité plateforme.
- **Télémétrie exploitée** : les `telemetry/runs.jsonl` permettent de mesurer
  les dimensions de qualité les plus faibles et de prioriser les amendements.
- **Nouveaux critics** : performance perçue, SEO, conformité légale par secteur.
- **Bibliothèque d'exemplaires enrichie** : plus le goût validé est capitalisé
  en images, plus la critique comparative est tranchante.
- **Métriques de ROI formalisées** : instrumenter le temps réel par feature
  pour transformer les estimations de §4 en chiffres mesurés.

---

## 7. Conclusion

Une semaine d'investissement (~30–90 $ de tokens, non récurrent) produit un
actif **réutilisable, distribué et auto-améliorant** qui relève le plancher de
qualité et économise des dizaines d'heures de travail senior sur chaque cycle
produit. Le coût en tokens est une ligne de bruit ; la valeur est dans
l'effet de levier répété.
