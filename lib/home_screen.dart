import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/screens/recipe_detail_screen.dart';
import 'package:hackathon/widgets/indicator.dart';
import 'package:hackathon/model/recipes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    SizeConfig().init(context);
    final horizonalBlock = SizeConfig.safeBlockHorizontal!;
    final verticalBlock = SizeConfig.safeBlockVertical!;
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: blue,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: blue,
                  ),
                  child: Column(
                    children: [
                      Text('Hello', style: TextStyle(color: Colors.white, fontSize: verticalBlock * 4)),
                      Text(FirebaseAuth.instance.currentUser!.email.toString(),
                          style: TextStyle(color: Colors.white, fontSize: verticalBlock * 2.5))
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Sign out'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ]),
        ),
        body: Stack(children: [
          Positioned(child: Container(height: verticalBlock * 40, color: blue, width: double.infinity)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: horizonalBlock * 10),
                child: Text(
                  "Retete pentru tine",
                  style: TextStyle(fontSize: verticalBlock * 3.5, color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: verticalBlock * 7),
                height: verticalBlock * 50,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  controller: mediaQuery.size.width < 450
                      ? PageController(viewportFraction: 0.65)
                      : PageController(viewportFraction: 0.4),
                  itemCount: allrecipes.length,
                  itemBuilder: (context, index) {
                    double scale = selectedIndex == index ? 1.0 : 0.8;
                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 350),
                      tween: Tween(begin: scale, end: scale),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetail(recipe: allrecipes[index])),
                            ),
                            child: Image.asset(
                              allrecipes[index].img,
                              height: verticalBlock * 40,
                            ),
                          ),
                          Text(allrecipes[index].name)
                        ],
                      ),
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      allrecipes.length, (index) => Indicator(selectedIndex == index ? true : false)),
                ],
              )
            ],
          ),
        ]));
  }
}
