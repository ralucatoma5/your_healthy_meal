import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/model/recipes_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackathon/widgets/recipe_card.dart';

class RecipeTypeGridView extends StatefulWidget {
  final type;
  final ScrollController controller;
  const RecipeTypeGridView({super.key, required this.type, required this.controller});

  @override
  State<RecipeTypeGridView> createState() => _RecipeTypeGridViewState();
}

class _RecipeTypeGridViewState extends State<RecipeTypeGridView> {
  List<Recipe> trecipes = [];
  @override
  void initState() {
    if (widget.type != "All") {
      for (int i = 0; i < allrecipes.length; i++) {
        if (allrecipes[i].type.contains(widget.type)) {
          trecipes.add(allrecipes[i]);
        }
      }
    } else {
      trecipes = allrecipes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        itemCount: widget.type != "All" ? trecipes.length : allrecipes.length,
        itemBuilder: (context, index) {
          final recipe = widget.type != "All" ? trecipes[index] : allrecipes[index];
          return RecipeCard(recipe: recipe);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index == 1 || index == 3 ? 1.90 : 1.80);
        },
      ),
    );
  }
}
