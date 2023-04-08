import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/model/recipes_model.dart';

class RecipeCard extends StatelessWidget {
  Recipe recipe;
  RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: recipe.dificulty == 'hard'
          ? Colors.red
          : recipe.dificulty == 'medium'
              ? Colors.orange
              : Colors.green,
      child: Column(
        children: [Text(recipe.name)],
      ),
    );
  }
}
