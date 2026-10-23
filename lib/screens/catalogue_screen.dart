import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../main.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Column(
      children: [
        const Text('Nouveautés'),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nouveautes.length,
            itemBuilder: (context, index) {
              final livre = nouveautes[index];
              return Container(
                width: 110,
                color: livre.couleur,
                alignment: Alignment.center,
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
        const Text('Tout le catalogue'),
        Expanded(
          child: ListView.separated(
            itemCount: livres.length,
            itemBuilder: (context, index) => livreTile(livres[index]),
            separatorBuilder: (context, index) => const Divider(indent: 72),
          ),
        ),
      ],
    );
  }
}
