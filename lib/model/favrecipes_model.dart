import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/screens/fav_recipes.screen.dart';

class FavRecipes {
  String id;
  List<String> favRecipesName;

  FavRecipes({
    required this.id,
    required this.favRecipesName,
  });

  factory FavRecipes.fromJSON(DocumentSnapshot doc) {
    return FavRecipes(
      id: doc['id'],
      favRecipesName: List<String>.from(doc['favRecipes']),
    );
  }
}
