import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/functions.dart';
import 'package:hackathon/model/recipes_model.dart';

class RecipeDetail extends StatefulWidget {
  Recipe recipe;
  RecipeDetail({super.key, required this.recipe});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  late bool favRecipe;
  late Color mainColor;
  @override
  void initState() {
    mainColor = widget.recipe.dificulty == 'greu'
        ? const Color(0xffdc6565)
        : widget.recipe.dificulty == 'mediu'
            ? const Color(0xfff4a43c)
            : const Color(0xff40916c);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              expandedHeight: verticalBlock * 45,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: mainColor,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mainColor,
                  child: Padding(
                    padding: EdgeInsets.only(left: horizontalBlock * 5, bottom: verticalBlock * 5),
                    child: Center(
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Hero(
                          tag: widget.recipe.name,
                          child: Image.asset(
                            widget.recipe.img,
                            height: verticalBlock * 28,
                          ),
                        ),
                        Positioned(
                          top: verticalBlock * 20,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('favoriteRecipes').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                if (snapshot.data!.docs[0]['favRecipes'].contains(widget.recipe.name)) {
                                  favRecipe = true;
                                  return CircleAvatar(
                                      radius: 20,
                                      backgroundColor: blue,
                                      child: IconButton(
                                        color: Colors.red,
                                        iconSize: 20,
                                        icon: Icon(Icons.favorite),
                                        onPressed: () {
                                          removeFromFavRecipes(widget.recipe.name);
                                        },
                                      ));
                                }
                              }
                              return CircleAvatar(
                                  radius: 20,
                                  backgroundColor: blue,
                                  child: IconButton(
                                    color: Colors.white,
                                    iconSize: 20,
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {
                                      addToFavRecipes(widget.recipe.name);
                                    },
                                  ));
                            },
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 9),
                  child: Text(
                    widget.recipe.name,
                    style: TextStyle(
                        color: Colors.white, fontSize: verticalBlock * 2.5, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              centerTitle: false,
            ),
            SliverToBoxAdapter(
                child: SizedBox(
                    width: double.maxFinite,
                    height: verticalBlock * 150,
                    child: Stack(
                      children: [
                        Positioned(
                            top: verticalBlock * 0,
                            bottom: 0,
                            child: Container(
                              width: horizontalBlock * 100,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: verticalBlock * 5,
                                    left: horizontalBlock * 8,
                                    right: horizontalBlock * 8,
                                    bottom: verticalBlock * 5),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('Valori nutritionale', style: subtitleStyle),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: verticalBlock * 3,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('settings')
                                              .where('id',
                                                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const CircularProgressIndicator.adaptive();
                                            } else {
                                              return snapshot.data!.docs[0]['arataKcal'] == true
                                                  ? Text('kcal: ${widget.recipe.kcal} ')
                                                  : SizedBox();
                                            }
                                          }),
                                      ListView.builder(
                                          padding: EdgeInsets.only(top: verticalBlock * 3),
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget.recipe.type.length,
                                          itemBuilder: ((context, index) {
                                            return widget.recipe.type[index] != 'All'
                                                ? Padding(
                                                    padding: EdgeInsets.only(bottom: verticalBlock),
                                                    child: Text(widget.recipe.type[index]),
                                                  )
                                                : SizedBox();
                                          })),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: verticalBlock * 5),
                                    child: horizonalLine,
                                  ),
                                  Text('Ingrediente', style: subtitleStyle),
                                  ListView.builder(
                                      padding: EdgeInsets.only(top: verticalBlock * 3),
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.recipe.type.length,
                                      itemBuilder: ((context, index) {
                                        return Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: verticalBlock),
                                              child: Text(widget.recipe.type[index]),
                                            )
                                          ],
                                        );
                                      })),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: verticalBlock * 5),
                                    child: horizonalLine,
                                  ),
                                  Text('Mod de preparare', style: subtitleStyle),
                                  ListView.builder(
                                      padding: EdgeInsets.only(top: verticalBlock * 3),
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.recipe.preparing.length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: verticalBlock),
                                          child: Text(widget.recipe.preparing[index]),
                                        );
                                      })),
                                ]),
                              ),
                            ))
                      ],
                    )))
          ],
        ));
  }
}
