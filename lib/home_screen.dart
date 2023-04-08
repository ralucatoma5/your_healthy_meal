import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  List<bool> switchValueVitamins = [false, false, false, false];
  List<String> vitamins = ['Vitamina D', 'Vitamina E', 'Vitamina C', 'Proteine'];
  bool switchValueKcal = true;
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
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: blue,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonalBlock * 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/drawer.png',
                    height: verticalBlock * 5,
                  ),
                  Text('Hello', style: TextStyle(color: Colors.white, fontSize: verticalBlock * 4)),
                  Text(FirebaseAuth.instance.currentUser!.email.toString(),
                      style: TextStyle(color: Colors.white, fontSize: verticalBlock * 2.5))
                ],
              ),
            ),
          ),
          SizedBox(
            height: verticalBlock * 2,
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(
              horizontal: 0,
              vertical: -4,
            ),
            leading: const Icon(Icons.logout_outlined),
            title: Text('Sign out',
                style: TextStyle(fontSize: verticalBlock * 2.5, fontWeight: FontWeight.w700)),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: switchValueVitamins.length,
              itemBuilder: ((context, index) {
                return ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vitamins[index], style: TextStyle(fontSize: verticalBlock * 2)),
                    CupertinoSwitch(
                      value: switchValueVitamins[index],
                      onChanged: (value) {
                        setState(() {
                          switchValueVitamins[index] = value;
                        });
                      },
                    ),
                  ],
                ));
              })),
          ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('kcal', style: TextStyle(fontSize: verticalBlock * 2)),
              CupertinoSwitch(
                value: switchValueKcal,
                onChanged: (value) {
                  setState(() {
                    switchValueKcal = value;
                  });
                },
              ),
            ],
          )),
        ]),
      ),
      /*body: Stack(children: [
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
        ])*/
    );
  }
}
