# MaBiblio

Application Flutter de gestion d'une bibliothèque personnelle. Elle permet de parcourir un catalogue de livres, de les afficher en liste ou en grille, de filtrer par genre, de marquer les livres lus et d'ajouter des favoris. Les choix de l'utilisateur sont sauvegardés et retrouvés au prochain lancement.

Projet réalisé dans le cadre du TP Flutter sur les listes, grilles, cartes et la gestion des données en JSON.

## Fonctionnalités

- **Catalogue** : section « Nouveautés » défilant horizontalement, puis liste de tous les livres sous forme de cartes (`Card`, `ListView.builder`).
- **Galerie** : grille responsive (2, 3 ou 4 colonnes selon la largeur de l'écran) avec bascule grille / liste et tri par note décroissante (`GridView.builder`).
- **Ma liste** : filtres par genre (`CheckboxListTile`, case « Tous les genres » à trois états), filtre « nouveautés », cases « lu » avec titre barré et compteur « Lus : X / Y ».
- **Détail** : fiche d'un livre (auteur, année, genre) avec ajout aux favoris.
- **Paramètres** : liste d'options (`ListTile`) et réinitialisation de la bibliothèque après confirmation.
- **Données JSON** : livres chargés depuis `assets/livres.json`, choix de l'utilisateur (lus, favoris) sauvegardés dans `mabiblio.json` (`path_provider`).
- **Navigation** : barre de navigation inférieure à trois onglets (Catalogue, Galerie, Ma liste).

## Captures d'écran

| Catalogue | Galerie (grille) | Galerie (liste) |
|---|---|---|
| ![Catalogue](captures/catalogue.png) | ![Galerie en grille](captures/galerie_grille.png) | ![Galerie en liste](captures/galerie_liste.png) |

| Ma liste | Détail | Paramètres |
|---|---|---|
| ![Ma liste](captures/ma_liste.png) | ![Détail](captures/detail.png) | ![Paramètres](captures/parametres.png) |

## Structure du projet

```text
assets/
  livres.json              # données des livres
lib/
  main.dart                # MaterialApp, HomePage (FutureBuilder + BottomNavigationBar)
  models/livre.dart        # classe Livre, fromJson / toJson
  services/livre_service.dart  # chargement et sauvegarde JSON
  screens/                 # Catalogue, Galerie, Ma liste, Détail, Paramètres
  widgets/                 # LivreCard, LivreGridItem
captures/                  # captures d'écran
reponses.md                # réponses aux questions du TP
```

## Lancer le projet

Prérequis : [Flutter](https://docs.flutter.dev/get-started/install) installé (`flutter doctor` sans erreur).

```bash
git clone https://github.com/rayenn-ar/ma-biblio.git
cd ma-biblio
flutter pub get
flutter run
```

Pour choisir la plateforme :

```bash
flutter devices          # liste des appareils disponibles
flutter run -d windows   # application de bureau Windows
flutter run -d android   # émulateur ou téléphone Android
```

> Sous Windows, le **mode développeur** doit être activé (`start ms-settings:developers`), car le projet utilise un plugin (`path_provider`).

## Auteur

Rayen Ayari
