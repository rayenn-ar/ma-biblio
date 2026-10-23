import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/livre.dart';

Future<File> _fichierSauvegarde() async {
  final dossier = await getApplicationDocumentsDirectory();
  return File('${dossier.path}/mabiblio.json');
}

Future<List<Livre>> chargerLivres() async {
  final fichier = await _fichierSauvegarde();
  final String contenu;
  if (await fichier.exists()) {
    contenu = await fichier.readAsString();
  } else {
    contenu = await rootBundle.loadString('assets/livres.json');
  }
  final List<dynamic> donnees = jsonDecode(contenu);
  return donnees
      .map((e) => Livre.fromJson(e as Map<String, dynamic>))
      .toList();
}

Future<void> sauvegarderLivres(List<Livre> livres) async {
  final fichier = await _fichierSauvegarde();
  await fichier.writeAsString(
    jsonEncode(livres.map((l) => l.toJson()).toList()),
  );
}

Future<void> supprimerSauvegarde() async {
  final fichier = await _fichierSauvegarde();
  if (await fichier.exists()) {
    await fichier.delete();
  }
}
