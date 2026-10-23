import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../services/livre_service.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;
  final List<Livre> livres;

  const DetailScreen({super.key, required this.livre, required this.livres});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              color: livre.couleur,
              alignment: Alignment.center,
              child: Text(
                livre.titre,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Auteur'),
              subtitle: Text(livre.auteur),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Année'),
              subtitle: Text('${livre.annee}'),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Genre'),
              subtitle: Text(livre.genre),
            ),
            OverflowBar(
              children: [
                TextButton.icon(
                  icon: Icon(
                    livre.favori ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: const Text('Ajouter aux favoris'),
                  onPressed: () {
                    setState(() {
                      livre.favori = !livre.favori;
                    });
                    sauvegarderLivres(widget.livres);
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Marquer comme lu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
