# Réponses – MaBiblio

## 1. `leading` et `trailing` dans un `ListTile`

**Différence :**
- `leading` est le widget placé **au début** de la ligne, à gauche du titre (en écriture de gauche à droite). On y met en général une icône ou un `CircleAvatar`, par exemple `Icons.person`.
- `trailing` est le widget placé **à la fin** de la ligne, à droite du titre. On y met en général une indication d'action ou une valeur, par exemple `Icons.chevron_right` ou la note d'un livre.
- Le `title` et le `subtitle` occupent tout l'espace restant entre les deux.

**Pourquoi un parent à largeur contrainte :**
Un `ListTile` prend **toute la largeur disponible**. Il en a besoin pour placer `leading` à gauche et `trailing` à droite, puis donner l'espace restant au `title`. Si son parent lui laisse une largeur **infinie** (non contrainte), par exemple un `Row` ou un `ListView` horizontal, il ne peut pas calculer sa taille. Flutter lève alors une erreur du type *« BoxConstraints forces an infinite width »*.
Il faut donc le placer dans un parent qui lui donne une largeur finie : `Column`, `ListView` vertical, `Card`, `SizedBox(width: …)`, ou `Expanded` s'il est dans un `Row`.

## 2. Q2.9 – `shrinkWrap: true` avec `NeverScrollableScrollPhysics()`

```dart
ListView.separated(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  ...
)
```

- `shrinkWrap: true` : au lieu de prendre une hauteur infinie, le `ListView` prend **la hauteur de son contenu**. L'erreur *« Vertical viewport was given unbounded height »* disparaît donc, même sans `Expanded`.
- `NeverScrollableScrollPhysics()` : le `ListView` **ne défile plus lui-même**. C'est le parent qui gère le défilement.

**Résultat du test dans `CatalogueScreen` :** la `Column` ne défile pas, donc avec 12 livres le contenu dépasse la hauteur de l'écran et une bande jaune et noire apparaît en bas. Pour que cette solution marche, il faut mettre toute la page dans un `SingleChildScrollView`. Toute la page défile alors d'un bloc.

**Quand l'utiliser :**
- pour une **petite liste**, de taille connue et limitée, placée **à l'intérieur d'une page qui défile déjà** (`SingleChildScrollView`), quand on veut que toute la page défile d'un bloc et non la liste seule. Par exemple, une fiche avec des informations en haut puis une courte liste de commentaires en dessous.

**À éviter pour les grandes listes :** `shrinkWrap` oblige à construire **tous** les éléments pour mesurer la hauteur totale. On perd le chargement paresseux de `ListView.builder`. Dans notre cas, `Expanded` reste la meilleure solution.

## 3. Q4.8 – Type de `DetailScreen`

`DetailScreen` doit être un **`StatefulWidget`**.

Le bouton « Ajouter aux favoris » change la valeur de `livre.favori`, et **l'icône doit changer à l'écran** (`Icons.favorite_border` → `Icons.favorite`). Pour que Flutter redessine l'écran après ce changement, il faut appeler `setState()`, qui n'existe que dans l'objet `State` d'un `StatefulWidget`.
Un `StatelessWidget` ne peut pas se reconstruire tout seul : la valeur changerait en mémoire, mais l'icône resterait la même.

```dart
onPressed: () {
  setState(() {
    livre.favori = !livre.favori;
  });
},
```

## 4. Q5.6 – `GridView.extent(maxCrossAxisExtent: 150)`

**Observation :** quand on **agrandit** la fenêtre (ou qu'on passe l'émulateur en paysage), **le nombre de colonnes augmente**. Quand on la **rétrécit**, il **diminue**. Les cases gardent une largeur proche de 150 px au maximum.

**Différence fondamentale avec `GridView.count` :**

| | `GridView.count` | `GridView.extent` |
|---|---|---|
| Ce qu'on fixe | le **nombre de colonnes** (`crossAxisCount`) | la **largeur maximale d'une case** (`maxCrossAxisExtent`) |
| Ce qui s'adapte à l'écran | la **taille des cases** | le **nombre de colonnes** |
| Sur un grand écran | quelques cases énormes | beaucoup de cases de taille raisonnable |

`GridView.extent` donne donc une grille **responsive**, adaptée à la fois au téléphone, à la tablette et au bureau.

## 5. Question de réflexion – Inconvénient de `GridView.count` et `GridView.extent`

Comme `ListView(children: …)`, ces deux constructeurs reçoivent une **liste `children` déjà construite**. **Tous les widgets sont donc créés dès le départ**, y compris ceux qui ne sont pas visibles à l'écran.

Avec un très grand nombre d'éléments (par exemple 1 000 livres) :
- **beaucoup de mémoire** est utilisée pour des widgets qu'on ne voit pas ;
- **l'ouverture de l'écran est lente**, car tous les éléments sont construits avant le premier affichage ;
- les performances baissent pour rien, puisque l'utilisateur n'en voit qu'une vingtaine à la fois.

**Solution :** utiliser **`GridView.builder`** avec un `gridDelegate`, soit `SliverGridDelegateWithFixedCrossAxisCount`, soit `SliverGridDelegateWithMaxCrossAxisExtent`. Comme `ListView.builder`, il est **paresseux** : il n'appelle `itemBuilder` que pour les cases visibles, plus quelques-unes autour. Les autres sont créées pendant le défilement, et celles qui sortent de l'écran sont libérées.

## 6. Question de réflexion – Tableau comparatif

| Constructeur | Nombre de colonnes (fixe / adaptatif) | Génération des éléments (tous / à la demande) | Cas d'usage conseillé |
|---|---|---|---|
| `GridView.count` | **Fixe** (`crossAxisCount`) | **Tous**, dès le départ (liste `children`) | Petit nombre d'éléments connu à l'avance, avec un nombre de colonnes imposé (menu de quelques icônes, galerie de 6 images) |
| `GridView.extent` | **Adaptatif** (`maxCrossAxisExtent` : le nombre de colonnes dépend de la largeur de l'écran) | **Tous**, dès le départ (liste `children`) | Petit nombre d'éléments à afficher sur des écrans de tailles variées (téléphone, tablette, bureau) |
| `GridView.builder` | **Fixe ou adaptatif**, selon le `gridDelegate` (`SliverGridDelegateWithFixedCrossAxisCount` ou `SliverGridDelegateWithMaxCrossAxisExtent`) | **À la demande** (`itemBuilder` n'est appelé que pour les cases visibles) | Grand nombre d'éléments ou liste dynamique (catalogue de livres, résultats d'une recherche, données chargées depuis une API) |
