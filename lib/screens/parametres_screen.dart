import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),
          const ListTile(leading: Icon(Icons.info), title: Text('À propos')),
        ],
      ),
    );
  }
}
