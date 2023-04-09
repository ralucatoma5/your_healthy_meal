import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String name;

  List<String> preparing;
  String img;
  String dificulty;
  int kcal;
  String mainVitamin;

  List<String> type;

  Recipe(
      {required this.name,
      required this.preparing,
      required this.img,
      required this.type,
      required this.dificulty,
      required this.kcal,
      required this.mainVitamin});

  factory Recipe.fromJSON(DocumentSnapshot doc) {
    return Recipe(
        name: doc['name'],
        preparing: List<String>.from(doc['preparing']),
        img: doc['img'],
        dificulty: doc['dificulty'],
        type: List<String>.from(doc['type']),
        kcal: doc['kcal'],
        mainVitamin: doc['mainVitamin']);
  }
}
