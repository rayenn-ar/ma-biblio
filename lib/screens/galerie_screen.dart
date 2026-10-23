import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';
import '../widgets/livre_grid_item.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  const GalerieScreen({super.key});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _enGrille = true;

  Future<void> _ouvrirDetail(Livre livre) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(livre: livre)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final int colonnes;
    if (largeur < 600) {
      colonnes = 2;
    } else if (largeur < 900) {
      colonnes = 3;
    } else {
      colonnes = 4;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() {
                livres.sort((a, b) => b.note.compareTo(a.note));
              });
            },
          ),
          IconButton(
            icon: Icon(_enGrille ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _enGrille = !_enGrille;
              });
            },
          ),
        ],
      ),
      body: _enGrille
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: livres.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colonnes,
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) => LivreGridItem(
                livre: livres[index],
                onTap: () => _ouvrirDetail(livres[index]),
              ),
            )
          : ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) => LivreCard(livre: livres[index]),
            ),
    );
  }
}
