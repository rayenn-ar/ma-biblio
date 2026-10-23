import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';
import 'screens/parametres_screen.dart';
import 'services/livre_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Livre>> _futurLivres;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _futurLivres = chargerLivres();
  }

  void _recharger() {
    setState(() {
      _futurLivres = chargerLivres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _futurLivres,
      builder: (context, snapshot) {
        Widget body;

        if (snapshot.connectionState == ConnectionState.waiting) {
          body = const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          body = Center(
            child: Text(
              '${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          final livres = snapshot.data!;
          final List<Widget> ecrans = [
            CatalogueScreen(livres: livres),
            GalerieScreen(livres: livres),
            MaListeScreen(livres: livres),
          ];
          body = ecrans[_index];
        }

        return Scaffold(
          appBar: _index == 0
              ? AppBar(
                  title: const Text('MaBiblio'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ParametresScreen(onReinitialiser: _recharger),
                          ),
                        );
                      },
                    ),
                  ],
                )
              : null,
          body: body,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Catalogue',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_on),
                label: 'Galerie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist),
                label: 'Ma liste',
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(livre.titre[0]),
    ),
    title: Text(livre.titre),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (livre.lu) const Icon(Icons.check_circle, color: Colors.green),
        if (livre.favori) const Icon(Icons.favorite, color: Colors.red),
        Text('${livre.note}'),
        const Icon(Icons.star, color: Colors.amber),
      ],
    ),
  );
}
