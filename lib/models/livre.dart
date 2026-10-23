import 'package:flutter/material.dart';

class Livre {
  final int id;
  final String titre;
  final String auteur;
  final String genre; // Roman, Science, Histoire, Jeunesse, Informatique
  final int annee;
  final double note; // sur 5
  final Color couleur; // couleur de la « couverture »
  final bool nouveaute;
  bool lu;
  bool favori;

  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.genre,
    required this.annee,
    required this.note,
    required this.couleur,
    this.nouveaute = false,
    this.lu = false,
    this.favori = false,
  });

  factory Livre.fromJson(Map<String, dynamic> json) {
    final hex = (json['couleur'] as String).substring(1);
    return Livre(
      id: json['id'] as int,
      titre: json['titre'] as String,
      auteur: json['auteur'] as String,
      genre: json['genre'] as String,
      annee: json['annee'] as int,
      note: (json['note'] as num).toDouble(),
      couleur: Color(int.parse('FF$hex', radix: 16)),
      nouveaute: json['nouveaute'] as bool,
      lu: json['lu'] as bool,
      favori: json['favori'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final hex = (couleur.toARGB32() & 0xFFFFFF)
        .toRadixString(16)
        .padLeft(6, '0')
        .toUpperCase();
    return {
      'id': id,
      'titre': titre,
      'auteur': auteur,
      'genre': genre,
      'annee': annee,
      'note': note,
      'couleur': '#$hex',
      'nouveaute': nouveaute,
      'lu': lu,
      'favori': favori,
    };
  }
}
