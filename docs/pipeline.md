# Pipeline du Product Builder — arbres de décision

Doc vivante du fonctionnement du kit, en arbres de décision oui/non. Texte
(Mermaid) plutôt qu'images : diffable, rendu nativement par GitHub, et
amendable comme le reste du kit via `/retro`.

**Comment lire** — la colonne centrale est le chemin nominal ; à chaque losange,
la branche qui descend est la réponse qui continue le pipeline (parfois *oui*,
parfois *non*, toujours étiquetée). Les sorties latérales mènent à un stop, une
question à Baptiste, ou une action qui reprend ensuite le flux.

| Couleur | Sens |
|---|---|
| 🟡 ambre (losange) | Décision oui/non |
| ⬜ gris | Étape automatique |
| 🟣 violet | Checkpoint humain (Baptiste) |
| 🔴 rouge | Stop / escalade / correction |
| 🟢 vert | Validé / shippé |

---

## Vue d'ensemble — `/feature`

Le pipeline complet, du brief au ship. Un seul checkpoint humain dans tout le
flux : la direction artistique (`/da`). Deux boucles se ferment seules — les
gates machine qui renvoient au build, et la correction qui relance la critique
(plafond 3 tours, sinon escalade).

```mermaid
flowchart TD
    S0(["/feature « une feature »"]):::step --> S1{"Valeur & scope nets ?<br/>product-challenger"}:::dec
    S1 -->|non| R1["rethink → stop<br/>décision de Baptiste"]:::stop
    S1 -->|oui| S2{"Infos produit manquantes ?"}:::dec
    S2 -->|oui| R2["Demande en 1 salve<br/>note CLAUDE.md, reprend"]:::human
    S2 -->|non| S3{"design/da.md existe ?"}:::dec
    S3 -->|non| R3["/da → 1 direction<br/>Baptiste valide"]:::human
    S3 -->|oui| S4{"Pattern ≥ 70 % couvert ?"}:::dec
    S4 -->|non| R4["pattern-researcher<br/>local → Mobbin → web"]:::step
    S4 -->|oui| S5["Build<br/>skills · tokens · signature"]:::step
    R2 --> S3
    R3 --> S4
    R4 --> S5
    S5 --> S6{"Screenshots faits ?"}:::dec
    S6 -->|non| R6["Hygiène sur le code<br/>pas de verdict ship"]:::dec
    S6 -->|oui| S7["Critique<br/>design-critic + code-reviewer"]:::step
    R6 --> S7
    S7 --> S8{"Gates machine OK ?<br/>typecheck · lint · code mort"}:::dec
    S8 -->|non| S5
    S8 -->|oui| S9{"Blocker ou major ?"}:::dec
    S9 -->|oui| S9b{"3 tours / oscillation ?"}:::dec
    S9b -->|oui| RX["STOP + escalade"]:::stop
    S9b -->|non| S7
    S9 -->|non| S10(["Shippé<br/>rapport + télémétrie"]):::ship
    S10 --> RT["/retro<br/>corrections → kit → push"]:::human
    classDef dec fill:#FAEEDA,stroke:#BA7517,color:#633806
    classDef step fill:#F1EFE8,stroke:#888780,color:#2C2C2A
    classDef human fill:#EEEDFE,stroke:#534AB7,color:#26215C
    classDef stop fill:#FCEBEB,stroke:#A32D2D,color:#501313
    classDef ship fill:#EAF3DE,stroke:#639922,color:#173404
```

---

## 1. Challenge produit — `product-challenger`

Ne valide pas le brief : le réduit à sa version minimale à forte valeur, ou le
rejette. Première ligne de défense contre la feature inutile et le scope qui
enfle. Source : [`agents/product-challenger.md`](../product-builder/agents/product-challenger.md).

```mermaid
flowchart TD
    A(["Brief de feature"]):::step --> B{"Problème en 1 phrase ?<br/>un user, une situation"}:::dec
    B -->|non| R1["rethink → stop<br/>2 reformulations"]:::stop
    B -->|oui| C{"Infos produit présentes ?<br/>users · secteur · contrainte"}:::dec
    C -->|non| R2["Demande à Baptiste<br/>note, puis reprend"]:::human
    C -->|oui| D{"Contournement existe ?<br/>alternative zéro"}:::dec
    D -->|oui| R3["Réduit ou exclut<br/>noté au rapport"]:::step
    D -->|non| E["Version 20/80<br/>scope minimal, forte valeur"]:::step
    R3 --> E
    E --> F["Coût caché + succès<br/>maintenance · 1-3 critères"]:::step
    F --> G(["Scope retenu<br/>go / go_réduit"]):::ship
    classDef dec fill:#FAEEDA,stroke:#BA7517,color:#633806
    classDef step fill:#F1EFE8,stroke:#888780,color:#2C2C2A
    classDef human fill:#EEEDFE,stroke:#534AB7,color:#26215C
    classDef stop fill:#FCEBEB,stroke:#A32D2D,color:#501313
    classDef ship fill:#EAF3DE,stroke:#639922,color:#173404
```

---

## 2. Direction artistique — `/da`

Le seul checkpoint humain du build. Collecte multi-sources (exemplaires du kit,
Mobbin, galeries web), puis on tranche **une** direction — pas un menu. Le
`@theme` du projet en dérive. Source : [`commands/da.md`](../product-builder/commands/da.md).

```mermaid
flowchart TD
    A(["Lancer /da · 1× par projet"]):::step --> B{"Territoire cadré ?<br/>users · secteur · ambiance"}:::dec
    B -->|non| R1["Demande à Baptiste<br/>note, puis reprend"]:::human
    B -->|oui| C["Collecte de références<br/>exemplaires → Mobbin → web"]:::step
    R1 --> C
    C --> D{"Une direction tranchée ?<br/>pas un menu d'options"}:::dec
    D -->|non| R2["↻ Commits-toi<br/>un seul parti-pris"]:::stop
    R2 --> D
    D -->|oui| E["Baptiste valide<br/>seul checkpoint humain"]:::human
    E --> F["Dérive le @theme<br/>via color · OKLCH"]:::step
    F --> G(["design/da.md écrit<br/>gouverne tous les builds"]):::ship
    classDef dec fill:#FAEEDA,stroke:#BA7517,color:#633806
    classDef step fill:#F1EFE8,stroke:#888780,color:#2C2C2A
    classDef human fill:#EEEDFE,stroke:#534AB7,color:#26215C
    classDef stop fill:#FCEBEB,stroke:#A32D2D,color:#501313
    classDef ship fill:#EAF3DE,stroke:#639922,color:#173404
```

---

## 3. Build — les gates de goût

Le nœud « Build » éclaté en ses gates binaires. C'est ici que vivent les skills
`design-judgment`, `color`, `anti-slop`, `art-direction` et `a11y` : le goût est
devenu une suite de oui/non vérifiables, plus une intention vague. Un seul *non*
sur n'importe quel gate → on corrige avant de continuer, jamais on shippe.

```mermaid
flowchart TD
    A(["Build du scope<br/>skills en parallèle"]):::step --> G1{"Hiérarchie claire ?<br/>1 action primaire"}:::dec
    G1 -->|oui| G2{"Tout en tokens ?<br/>zéro valeur hardcodée"}:::dec
    G2 -->|oui| G3{"Palette = système ?<br/>rampe OKLCH · 1 accent · AA"}:::dec
    G3 -->|oui| G4{"Aucun slop ?<br/>interdits + défaut Tailwind"}:::dec
    G4 -->|oui| G5{"Retenue + geste fort ?<br/>test du retrait · signature"}:::dec
    G5 -->|oui| G6{"États + a11y ?<br/>hover…error · clavier · focus"}:::dec
    G6 -->|oui| OK(["Écran prêt pour critique"]):::ship
    G1 -->|non| FIX["↻ corrige,<br/>puis re-vérifie tout"]:::stop
    G2 -->|non| FIX
    G3 -->|non| FIX
    G4 -->|non| FIX
    G5 -->|non| FIX
    G6 -->|non| FIX
    classDef dec fill:#FAEEDA,stroke:#BA7517,color:#633806
    classDef step fill:#F1EFE8,stroke:#888780,color:#2C2C2A
    classDef stop fill:#FCEBEB,stroke:#A32D2D,color:#501313
    classDef ship fill:#EAF3DE,stroke:#639922,color:#173404
```

Ces gates correspondent aux skills : [`design-judgment`](../product-builder/skills/design-judgment/SKILL.md) ·
[`color`](../product-builder/skills/color/SKILL.md) ·
[`anti-slop`](../product-builder/skills/anti-slop/SKILL.md) ·
[`art-direction`](../product-builder/skills/art-direction/SKILL.md) ·
[`a11y`](../product-builder/skills/a11y/SKILL.md).

---

## 4. Critique & boucle de correction

Les deux critics tournent en parallèle, puis le verdict décide : ship, corriger,
ou escalader. Seule boucle qui se ferme seule (plafond 3 tours). Le design-critic
re-teste les gates de goût du build (§3) : c'est la double barrière build-puis-audit.
Source : [`agents/design-critic.md`](../product-builder/agents/design-critic.md), [`commands/feature.md`](../product-builder/commands/feature.md).

```mermaid
flowchart TD
    A(["Critique (parallèle)<br/>design-critic + code-reviewer"]):::step --> B{"Verdict = rethink ?<br/>pattern structurel mauvais"}:::dec
    B -->|oui| R1["rethink → Baptiste tranche<br/>pas une correction cosmétique"]:::stop
    B -->|non| C{"Blocker ou major ?<br/>selon la rubrique"}:::dec
    C -->|non| S(["Ship<br/>rapport + télémétrie"]):::ship
    C -->|oui| D["Corrige les blocker/major<br/>+ minor au passage"]:::step
    D --> E{"3 tours / oscillation ?<br/>ou 2 tours sans progrès"}:::dec
    E -->|oui| R2["STOP + escalade<br/>rapport des options"]:::stop
    E -->|non| A
    classDef dec fill:#FAEEDA,stroke:#BA7517,color:#633806
    classDef step fill:#F1EFE8,stroke:#888780,color:#2C2C2A
    classDef stop fill:#FCEBEB,stroke:#A32D2D,color:#501313
    classDef ship fill:#EAF3DE,stroke:#639922,color:#173404
```

---

## Amender cette doc

Ce sont des schémas, pas la source de vérité : les règles vivent dans les
commandes, agents et skills liés ci-dessus. Quand le pipeline change (via
`/retro`), mettre à jour le diagramme concerné ici dans le même commit — comme
pour la doctrine tokens, deux formulations divergentes finissent par coûter un
incident.
