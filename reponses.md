# Réponses – MaBiblio

## Partie 00

### Q0.8

À compléter.

---

## Partie 01 – ListTile

### Q1.2 – Effet du `onTap`

Quand on clique sur « Mon profil », une petite onde grise part de l'endroit où on a cliqué et s'étale sur toute la ligne avant de disparaître : c'est l'effet d'encre (le *ripple*). En même temps, le SnackBar « Profil sélectionné » s'affiche en bas de l'écran pendant quelques secondes.

Si on enlève le `onTap`, la ligne devient un simple affichage. Le clic ne fait plus rien, et l'effet d'encre disparaît aussi, parce que Flutter considère que la ligne n'est plus interactive.

### Q1.4 – `dense`, `isThreeLine` et `enabled`

- `dense: true` rend la ligne plus serrée : elle est moins haute et le texte est un peu plus petit.
- `isThreeLine: true`, avec un sous-titre sur deux lignes, agrandit la ligne pour laisser la place au sous-titre. On remarque aussi que l'icône de gauche se place en haut au lieu de rester centrée.
- `enabled: false` grise toute la ligne (icône et textes) et la rend insensible au clic : pas de `onTap`, pas d'effet d'encre.

### Question de réflexion – `leading`, `trailing` et largeur contrainte

`leading` est ce qu'on met au début de la ligne, à gauche du titre : en général une icône ou un avatar. `trailing` est à l'autre bout, à droite : souvent une flèche, une valeur (comme la note du livre) ou un bouton. Le titre et le sous-titre prennent la place qui reste au milieu.

Un `ListTile` a besoin de connaître sa largeur, parce qu'il s'étale sur toute la largeur disponible pour placer `leading` à gauche, `trailing` à droite et le titre entre les deux. Si on le met dans un parent qui ne limite pas la largeur, comme un `Row` ou une liste horizontale, il n'a aucune limite et ne peut pas calculer sa taille. Flutter affiche alors une erreur du genre « BoxConstraints forces an infinite width ». Il faut donc le mettre dans une `Column`, un `ListView` vertical, une `Card`, un `SizedBox` avec une largeur, ou dans un `Expanded` s'il est à l'intérieur d'un `Row`.

---

## Partie 02 – ListView

### Q2.1 – L'erreur avec une `Column` trop longue

En ajoutant 10 `ListTile` (ou en passant en mode paysage), une bande jaune et noire apparaît en bas de l'écran avec le message « A RenderFlex overflowed by … pixels on the bottom ».

Ça vient du fait qu'une `Column` ne défile pas. Elle essaie de faire tenir tous ses enfants dans la hauteur de l'écran, et quand il n'y a plus de place, ce qui dépasse est coupé. La bande jaune et noire sert justement à signaler ce débordement. Pour corriger, on remplace la `Column` par un `ListView`, qui lui sait défiler.

### Q2.5 – Pourquoi `ListView.builder` pour 1 000 livres

Avec `ListView(children: …)`, on donne directement la liste complète des widgets. Flutter construit donc les 1 000 lignes dès l'ouverture de l'écran, même celles qu'on ne voit pas. Ça prend de la mémoire et ça ralentit l'affichage.

`ListView.builder` fonctionne autrement : il ne construit que les lignes visibles, plus quelques-unes autour. Les autres sont créées au fur et à mesure qu'on fait défiler, et celles qui sortent de l'écran sont libérées. Que la liste contienne 10 ou 1 000 livres, l'écran reste aussi rapide.

### Q2.8 – L'erreur sans `Expanded`

Dans `CatalogueScreen`, la `Column` contient le titre « Nouveautés », la liste horizontale dans un `SizedBox` de 160 px, le titre « Tout le catalogue » puis la liste verticale.

Sans `Expanded` autour de la liste verticale, on obtient l'erreur « Vertical viewport was given unbounded height ». Le problème, c'est qu'une `Column` laisse une hauteur illimitée à ses enfants, alors qu'un `ListView` veut prendre toute la hauteur qu'on lui donne. Avec une hauteur infinie, il ne sait pas quelle taille prendre.

En le mettant dans un `Expanded`, on lui dit de prendre exactement l'espace qui reste dans la `Column`, et l'erreur disparaît. La liste horizontale n'a pas ce problème, puisque son `SizedBox` lui fixe déjà une hauteur.

---

## Partie 03 – CheckboxListTile

### Q3.1 – Pourquoi un `StatefulWidget`

Sur cet écran, l'affichage change dès que l'utilisateur coche ou décoche quelque chose : les filtres, les livres lus, le compteur dans la barre du haut. Un `StatelessWidget` ne peut pas faire ça. Il est construit une fois avec des valeurs fixes et n'a aucun moyen de se redessiner. Le `StatefulWidget`, lui, garde ses variables dans un objet `State` et peut se reconstruire avec `setState` à chaque changement.

### Q3.2 – Si on oublie `setState`

Si on oublie `setState`, la variable `_nouveautesSeulement` change bien, mais Flutter n'est pas prévenu qu'il doit redessiner l'écran. Résultat : on clique et la case ne se coche pas, on a l'impression que rien ne s'est passé. Le changement n'apparaît que plus tard, quand autre chose provoque une reconstruction de l'écran.

---

## Partie 04 – Card

### Q4.3 – `color` et `surfaceTintColor`

`color` change directement le fond de la carte : la couleur est la même, quelle que soit l'élévation.

`surfaceTintColor`, qui vient de Material 3, ne remplace pas le fond. C'est une teinte légère posée par-dessus, et elle dépend de l'élévation : avec une élévation à 0 on la voit à peine, alors qu'à 12 la carte est nettement colorée. Material 3 s'en sert pour faire sentir qu'un élément est plus ou moins « haut », en plus de l'ombre.

### Q4.5 – Pourquoi `clipBehavior: Clip.antiAlias`

Par défaut, la `Card` dessine bien ses coins arrondis, mais elle ne coupe pas ce qu'elle contient. L'effet d'encre de l'`InkWell` est dessiné sur un rectangle, donc pendant l'animation il déborde dans les coins, qui paraissent carrés.

Avec `clipBehavior: Clip.antiAlias`, la carte découpe son contenu selon sa forme arrondie, avec des bords lissés. L'effet d'encre reste alors bien à l'intérieur des coins.

---

## Partie 05 – GridView

### Q5.2 – Axe principal et axe secondaire

L'axe principal, c'est le sens dans lequel la grille défile. Pour une grille verticale, c'est donc de haut en bas, et `mainAxisSpacing` règle l'espace entre les lignes.

L'axe secondaire est perpendiculaire : pour une grille verticale, c'est la largeur. `crossAxisSpacing` règle l'espace entre les colonnes, et `crossAxisCount` le nombre de colonnes.

### Q5.3 – `crossAxisCount` et `childAspectRatio`

En passant à 3 puis à 4 colonnes, les cases rétrécissent, parce que la même largeur est partagée entre plus de colonnes.

`childAspectRatio` correspond à la largeur divisée par la hauteur d'une case. Avec 1.5, les cases sont plus larges que hautes ; avec 1.0, elles sont carrées ; avec 0.7, elles sont plus hautes que larges. C'est donc 0.7 qui ressemble à une couverture de livre, et c'est la valeur que j'ai gardée.

### Q5.6 – `GridView.extent`

En redimensionnant la fenêtre, on voit le nombre de colonnes changer : plus la fenêtre est large, plus il y a de colonnes, et quand on la rétrécit, il en reste moins. Les cases, elles, gardent à peu près la même taille, autour de 150 px maximum.

C'est la vraie différence avec `GridView.count`. Avec `count`, on fixe le nombre de colonnes et ce sont les cases qui s'agrandissent ou rétrécissent selon l'écran : sur un grand écran, on se retrouve avec quelques cases énormes. Avec `extent`, on fixe la taille maximale d'une case et c'est le nombre de colonnes qui s'adapte. La grille reste donc agréable sur un téléphone comme sur un ordinateur.

### Question de réflexion – L'inconvénient de `GridView.count` et `GridView.extent`

Ces deux constructeurs ont le même défaut que `ListView(children: …)` : on leur passe une liste de widgets déjà prête, donc toutes les cases sont construites dès le départ, même celles qui ne sont pas à l'écran.

Avec quelques dizaines de livres, on ne voit pas la différence. Mais avec des milliers, l'écran met du temps à s'ouvrir et consomme beaucoup de mémoire pour des cases que l'utilisateur ne verra peut-être jamais. Dans ce cas, il vaut mieux utiliser `GridView.builder`, qui construit les cases seulement quand elles deviennent visibles.

---

## Partie 06 – GridView.builder

### Q6.3 – `SliverGridDelegateWithMaxCrossAxisExtent`

Ce délégué fait la même chose que `GridView.extent` de la partie 05 : on fixe une largeur maximale pour les cases, et le nombre de colonnes s'adapte à la largeur de l'écran. De la même manière, `SliverGridDelegateWithFixedCrossAxisCount` correspond à `GridView.count`. La seule différence, c'est qu'avec `GridView.builder` les cases sont construites au fur et à mesure.

### Tableau comparatif

| Constructeur | Nombre de colonnes (fixe / adaptatif) | Génération des éléments (tous / à la demande) | Cas d'usage conseillé |
|---|---|---|---|
| `GridView.count` | Fixe, avec `crossAxisCount` | Tous, dès le départ | Peu d'éléments, avec un nombre de colonnes voulu (par exemple un menu de 6 icônes) |
| `GridView.extent` | Adaptatif : il dépend de la largeur de l'écran et de `maxCrossAxisExtent` | Tous, dès le départ | Peu d'éléments, mais une application utilisée sur des écrans de tailles différentes |
| `GridView.builder` | Fixe ou adaptatif, selon le `gridDelegate` choisi | À la demande, seulement les cases visibles | Beaucoup d'éléments ou une liste qui change (catalogue, résultats de recherche, données d'une API) |

---

## Partie 07 – JSON

### Q7.2 – Une mauvaise indentation de `assets:`

Le fichier `pubspec.yaml` est en YAML, un format où c'est l'indentation qui donne la structure. `assets:` doit être décalé de 2 espaces sous `flutter:`, et chaque fichier de 4 espaces avec un tiret :

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/livres.json
```

Si on se trompe, deux choses peuvent arriver. Si `assets:` est collé tout à gauche, il n'appartient plus à la section `flutter:` : la déclaration est ignorée, le fichier n'est pas ajouté à l'application, et le chargement échoue au lancement avec « Unable to load asset ». Si l'indentation est incohérente (3 espaces, une tabulation…), le fichier YAML devient invalide et `flutter pub get` s'arrête avec une erreur de syntaxe, ce qui empêche de compiler.

### Q7.4 – Pourquoi `chargerLivres()` est `async`

Lire un fichier ne se fait pas instantanément, que ce soit dans les assets ou sur le disque. Les fonctions de lecture renvoient donc un `Future`, c'est-à-dire un résultat qui arrivera un peu plus tard.

En déclarant la fonction `async`, on peut utiliser `await` pour attendre ce résultat sans bloquer l'application. Pendant le chargement, l'interface continue de fonctionner, et c'est pour ça qu'on peut afficher le petit cercle de chargement. Sans ça, l'écran resterait figé jusqu'à la fin de la lecture. C'est aussi pour cette raison que la fonction renvoie un `Future<List<Livre>>` et qu'on l'affiche avec un `FutureBuilder`.

### Q7.6 – L'avantage du fichier JSON

Avant, les livres étaient écrits directement dans le code, dans `livres_data.dart`. Pour en ajouter un, il fallait toucher au code Dart et faire attention à la syntaxe.

Avec `livres.json`, les données sont séparées du code. On peut ajouter ou modifier un livre sans toucher à une seule ligne de Dart, et le JSON est assez simple pour que n'importe qui puisse le modifier. C'est aussi le format qu'utilisent les API sur Internet : plus tard, on pourra charger les livres depuis un serveur sans changer les écrans ni `Livre.fromJson`. Enfin, le même format nous sert pour sauvegarder les choix de l'utilisateur dans `mabiblio.json`.

Petite remarque : comme `mabiblio.json` est lu en priorité quand il existe, un livre ajouté dans `livres.json` n'apparaît qu'après avoir réinitialisé la bibliothèque.

### Question de réflexion 1 – Pourquoi on ne peut pas écrire dans `assets/livres.json`

Les assets sont intégrés à l'application au moment de la compilation. Une fois l'application installée, ils font partie du paquet (l'APK sur Android, par exemple) et sont en lecture seule. D'ailleurs, `rootBundle` ne propose que des fonctions de lecture. Sur mobile, le paquet est en plus signé et protégé par le système, donc on ne peut pas le modifier.

Pour enregistrer quelque chose, il faut écrire dans un dossier prévu pour ça, propre à l'application. C'est ce que donne `getApplicationDocumentsDirectory()` avec `path_provider`.

### Question de réflexion 2 – `jsonDecode` / `jsonEncode` et `fromJson` / `toJson`

Ce sont deux étapes différentes qui se complètent.

`jsonDecode` et `jsonEncode`, qui viennent de `dart:convert`, s'occupent du texte JSON. `jsonDecode` transforme le texte en `Map` et en `List` Dart, et `jsonEncode` fait l'inverse. Mais ils ne savent rien de notre classe `Livre`.

`fromJson` et `toJson`, c'est nous qui les écrivons dans la classe `Livre`. Ils font le lien entre une `Map` et un vrai objet `Livre` : ils savent quel champ correspond à quoi, convertissent la note en `double` et transforment la couleur `"#0288D1"` en `Color(0xFF0288D1)`, et inversement.

À la lecture, on passe donc du texte à une `Map` avec `jsonDecode`, puis de la `Map` à un `Livre` avec `fromJson`. À l'écriture, c'est le chemin inverse : `toJson` puis `jsonEncode`.

### Question de réflexion 3 – Une solution pour Flutter Web

Dans un navigateur, une page web n'a pas le droit d'accéder aux fichiers de l'ordinateur, pour des raisons de sécurité. C'est pour ça que `dart:io` et `path_provider` ne fonctionnent pas sur le web.

On peut utiliser à la place le package `shared_preferences`. Il permet d'enregistrer des valeurs associées à une clé, et il marche sur toutes les plateformes : sur le web, il utilise le `localStorage` du navigateur. Il suffit d'enregistrer notre JSON comme une simple chaîne de caractères :

```dart
final prefs = await SharedPreferences.getInstance();

// Sauvegarder
await prefs.setString('mabiblio', jsonEncode(livres.map((l) => l.toJson()).toList()));

// Relire
final contenu = prefs.getString('mabiblio');

// Réinitialiser
await prefs.remove('mabiblio');
```

C'est bien adapté pour une petite quantité de données comme nos 12 livres. Pour beaucoup plus de données, il vaudrait mieux passer par une vraie base de données locale, comme `sqflite` ou `hive`.

---

## Compléments

### Q2.9 – `shrinkWrap: true` avec `NeverScrollableScrollPhysics()`

Avec `shrinkWrap: true`, le `ListView` ne cherche plus à prendre toute la hauteur : il prend juste la hauteur de son contenu, et l'erreur de hauteur infinie disparaît même sans `Expanded`. `NeverScrollableScrollPhysics()` l'empêche de défiler tout seul.

En le testant dans `CatalogueScreen`, on voit que ça ne suffit pas : la `Column` ne défile pas, donc avec 12 livres le bas de la liste déborde de l'écran. Il faudrait mettre toute la page dans un `SingleChildScrollView` pour que l'ensemble défile.

J'utiliserais cette solution pour une petite liste placée dans une page qui défile déjà, par exemple quelques commentaires sous la fiche d'un livre. Pour une longue liste, c'est une mauvaise idée, parce que `shrinkWrap` oblige à construire tous les éléments pour connaître la hauteur totale. Ici, `Expanded` reste le meilleur choix.

### Q4.8 – Le type de `DetailScreen`

`DetailScreen` doit être un `StatefulWidget`. Quand on clique sur « Ajouter aux favoris », l'icône du cœur doit changer tout de suite à l'écran, et pour ça il faut appeler `setState`, qui n'existe que dans un `StatefulWidget`.

### Q8.3 – Cohérence des données

Une bonne partie marchait déjà. Tous les écrans utilisent la même liste de livres, chargée une seule fois au démarrage : quand on coche un livre « lu » dans Ma liste ou qu'on l'ajoute aux favoris, c'est le même objet qui est modifié partout. Quand on change d'onglet, l'écran est redessiné avec les bonnes valeurs. Et comme chaque changement est enregistré dans `mabiblio.json`, on retrouve ses choix après avoir relancé l'application.

Il y avait quand même deux problèmes. D'abord, en revenant du Détail vers le Catalogue, le favori n'apparaissait pas. La donnée avait bien changé, mais le Catalogue était un `StatelessWidget` et rien ne lui demandait de se redessiner. Ensuite, le Catalogue n'affichait de toute façon ni les livres lus ni les favoris, et la Galerie ne montrait pas les livres lus.

Pour corriger le premier problème, j'ai transformé le Catalogue en `StatefulWidget` et ajouté un `setState` au retour du Détail :

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailScreen(livre: livre, livres: livres)),
).then((_) => setState(() {}));
```

`Navigator.push` renvoie un `Future` qui se termine quand on revient en arrière : à ce moment-là, `setState` redessine la liste. La Galerie fait la même chose avec `await`. Pour le second problème, j'ai ajouté une coche verte pour les livres lus et un cœur rouge pour les favoris dans les cartes du Catalogue, et une coche en haut à gauche dans les cases de la Galerie.
