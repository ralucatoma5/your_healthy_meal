import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/const.dart';
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
                color: Colors.black,
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
                            child: CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                color: Colors.black,
                                iconSize: 23,
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {},
                              ),
                            )),
                      ]),
                    ),
                  ),
                ),
                title: Text(
                  widget.recipe.name,
                  style: TextStyle(
                      color: Colors.white, fontSize: verticalBlock * 3, fontWeight: FontWeight.w600),
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
                                child: Text(widget.recipe.txt, style: TextStyle(fontSize: verticalBlock * 2)),
                              ),
                            ))
                      ],
                    )))
          ],
        ));
  }
}
