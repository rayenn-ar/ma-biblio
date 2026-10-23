import 'package:flutter/material.dart';

import '../services/livre_service.dart';

class ParametresScreen extends StatelessWidget {
  final VoidCallback onReinitialiser;

  const ParametresScreen({super.key, required this.onReinitialiser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              subtitle: const Text('Nom, e-mail, mot de passe'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil sélectionné')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              tileColor: Colors.indigo.shade50,
              iconColor: Colors.indigo,
              textColor: Colors.indigo.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.language),
              title: Text('Langue'),
              subtitle: Text('Français'),
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('À propos'),
              subtitle: Text(
                'MaBiblio version 1.0\nApplication de gestion de bibliothèque',
              ),
              dense: true,
              isThreeLine: true,
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.restart_alt),
              title: const Text('Réinitialiser ma bibliothèque'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Réinitialiser ma bibliothèque'),
                    content: const Text(
                      'Tous les livres lus et les favoris seront effacés.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await supprimerSauvegarde();
                          onReinitialiser();
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                        },
                        child: const Text('Réinitialiser'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
