import 'package:flutter/material.dart';

import '../data/livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  final Map<String, IconData> _icones = {
    'Roman': Icons.menu_book,
    'Science': Icons.science,
    'Histoire': Icons.history_edu,
    'Jeunesse': Icons.child_care,
    'Informatique': Icons.computer,
  };

  bool? get _tousLesGenres {
    if (_genres.values.every((coche) => coche)) return true;
    if (_genres.values.every((coche) => !coche)) return false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final livresAffiches = livres
        .where((livre) => _genres[livre.genre]!)
        .where((livre) => !_nouveautesSeulement || livre.nouveaute)
        .toList();
    final nombreLus = livresAffiches.where((livre) => livre.lu).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / ${livresAffiches.length}'),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            onChanged: (value) {
              setState(() {
                _nouveautesSeulement = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: _tousLesGenres,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              final nouvelleValeur = _tousLesGenres != true;
              setState(() {
                for (final genre in _genres.keys) {
                  _genres[genre] = nouvelleValeur;
                }
              });
            },
          ),
          ..._genres.keys.map(
            (genre) => CheckboxListTile(
              title: Text(genre),
              subtitle: Text(
                '${livres.where((livre) => livre.genre == genre).length} livres',
              ),
              secondary: Icon(_icones[genre]),
              activeColor: Colors.teal,
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (value) {
                setState(() {
                  _genres[genre] = value!;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: livresAffiches.length,
              itemBuilder: (context, index) {
                final livre = livresAffiches[index];
                return CheckboxListTile(
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  value: livre.lu,
                  onChanged: (value) {
                    setState(() {
                      livre.lu = value!;
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
