import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/model/recipes_model.dart';
import 'package:hackathon/widgets/recipe_gridview.dart';

class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({super.key});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  late TabController _tabController;
  static List<Tab> myTabs = <Tab>[
    const Tab(
      child: Text(
        'Toate',
      ),
    ),
    const Tab(
      child: Text(
        'Vitamina D',
      ),
    ),
    const Tab(
      child: Text(
        'Vitamina E',
      ),
    ),
    const Tab(
      child: Text(
        'Viatamina C',
      ),
    ),
    const Tab(
      child: Text(
        'Proteine',
      ),
    )
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  centerTitle: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(verticalBlock * 10),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalBlock * 5, vertical: verticalBlock * 1),
                      child: TabBar(
                        controller: _tabController,
                        tabs: myTabs,
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        unselectedLabelColor: Color.fromARGB(255, 175, 174, 174),
                        labelColor: blue,
                        labelStyle: TextStyle(fontSize: verticalBlock * 2.2, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: TextStyle(fontSize: verticalBlock * 2),
                        labelPadding: const EdgeInsets.only(right: 35),
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(top: verticalBlock * 2),
                    child: Text('Retete sanatoase',
                        style: TextStyle(
                            color: blue, fontSize: verticalBlock * 3.8, fontWeight: FontWeight.w700)),
                  )),
            ];
          },
          body: TabBarView(
            children: [
              RecipeTypeGridView(type: 'Toate', controller: controller),
              RecipeTypeGridView(type: 'Vitamina D', controller: controller),
              RecipeTypeGridView(type: 'Vitamina E', controller: controller),
              RecipeTypeGridView(type: 'Vitamina C', controller: controller),
              RecipeTypeGridView(type: 'Proteine', controller: controller),
            ],
            controller: _tabController,
          )),
    );
  }
}
