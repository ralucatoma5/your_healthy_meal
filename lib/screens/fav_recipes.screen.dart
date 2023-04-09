import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hackathon/const.dart';
import 'package:hackathon/functions.dart';
import 'package:hackathon/model/recipes_model.dart';
import 'package:hackathon/screens/recipe_detail_screen.dart';

class FavRecipes extends StatelessWidget {
  const FavRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    late bool favRecipe;
    final verticalBlock = SizeConfig.safeBlockVertical!;
    final horizontalBlock = SizeConfig.safeBlockHorizontal!;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('favoriteRecipes')
                .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator.adaptive();
              } else {
                if (snapshot.data!.docs.isNotEmpty) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalBlock * 3, vertical: verticalBlock * 2.5),
                            child: Text('Retetele favorite',
                                style: TextStyle(
                                    color: blue, fontSize: verticalBlock * 3.5, fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(height: verticalBlock * 4),
                          ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs[0]['favRecipes'].length,
                              itemBuilder: ((context, index) {
                                return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('recipe')
                                        .where('name', isEqualTo: snapshot.data!.docs[0]['favRecipes'][index])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const CircularProgressIndicator.adaptive();
                                      } else {
                                        Recipe recipe = Recipe.fromJSON(snapshot.data!.docs[0]);
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => RecipeDetail(recipe: recipe)),
                                          ),
                                          child: Container(
                                              height: verticalBlock * 16,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: horizontalBlock * 3,
                                                  vertical: verticalBlock * 1.5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                boxShadow: [containerShadow],
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    recipe.img,
                                                    height: verticalBlock * 12,
                                                  ),
                                                  Container(
                                                      width: horizontalBlock * 40, child: Text(recipe.name)),
                                                  StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore.instance
                                                        .collection('favoriteRecipes')
                                                        .snapshots(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.hasData &&
                                                          snapshot.data!.docs.isNotEmpty) {
                                                        if (snapshot.data!.docs[0]['favRecipes']
                                                            .contains(recipe.name)) {
                                                          favRecipe = true;
                                                          return CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor: blue,
                                                              child: IconButton(
                                                                color: Colors.red,
                                                                iconSize: 20,
                                                                icon: Icon(Icons.favorite),
                                                                onPressed: () {
                                                                  removeFavAlert(context, recipe.name);
                                                                },
                                                              ));
                                                        }
                                                      }
                                                      return SizedBox();
                                                    },
                                                  ),
                                                ],
                                              )),
                                        );
                                      }
                                    });
                              })),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              }
            }));
  }
}
