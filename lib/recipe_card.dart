import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/model/recipes_model.dart';
import 'package:hackathon/screens/recipe_detail_screen.dart';

class RecipeCard extends StatelessWidget {
  Recipe recipe;
  RecipeCard({super.key, required this.recipe});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetail(recipe: recipe)),
        );
      },
      child: Container(
        color: recipe.dificulty == 'hard'
            ? Colors.red
            : recipe.dificulty == 'medium'
                ? Colors.orange
                : Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              recipe.img,
              height: verticalBlock * 15,
            ),
            Text(recipe.name, style: TextStyle(color: Colors.white)),
            Icon(Icons.favorite_border, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
