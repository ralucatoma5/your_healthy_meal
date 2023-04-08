import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/model/recipes_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackathon/widgets/recipe_card.dart';

class RecipeTypeGridView extends StatefulWidget {
  final type;
  final ScrollController controller;

  RecipeTypeGridView({super.key, required this.type, required this.controller});

  @override
  State<RecipeTypeGridView> createState() => _RecipeTypeGridViewState();
}

class _RecipeTypeGridViewState extends State<RecipeTypeGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('recipe')
                .where('type', arrayContains: widget.type)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator.adaptive();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Recipe recipe = Recipe.fromJSON(snapshot.data!.docs[index]);

                      return RecipeCard(recipe: recipe);
                    },
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, index == 1 || index == 3 ? 2 : 1.90);
                    },
                  ),
                );
              }
            }));
  }
}
