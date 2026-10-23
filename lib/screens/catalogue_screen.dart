import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatefulWidget {
  final List<Livre> livres;

  const CatalogueScreen({super.key, required this.livres});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    final livres = widget.livres;
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
          child: ListView.builder(
            itemCount: livres.length,
            itemBuilder: (context, index) => LivreCard(
              livre: livres[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(livre: livres[index], livres: livres),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
          ),
        ),
      ],
    );
  }
}
