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
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(85),
          boxShadow: [containerShadow],
          color: Color.fromARGB(255, 238, 238, 238),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: recipe.name,
                child: Image.asset(
                  recipe.img,
                  height: verticalBlock * 18,
                ),
              ),
              Text(recipe.name,
                  style: TextStyle(color: blue, fontSize: verticalBlock * 2.5, fontWeight: FontWeight.w700)),
              Text(
                'dificultate: ${recipe.dificulty}',
                style: TextStyle(
                    color: recipe.dificulty == 'greu'
                        ? const Color(0xffdc6565)
                        : recipe.dificulty == 'mediu'
                            ? const Color(0xfff4a43c)
                            : const Color(0xff40916c),
                    fontWeight: FontWeight.w800),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: blue,
                child: IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
