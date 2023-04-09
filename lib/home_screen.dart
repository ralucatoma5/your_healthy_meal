import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/functions.dart';
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
  List<String> vitaminList = [];
  late bool switchValueD;
  late bool switchValueE;
  late bool switchValueC;
  late bool switchValueP;
  List<Recipe> finalList = [];
  List<String> vitamins = ['Vitamina D', 'Vitamina E', 'Vitamina C', 'Proteine'];
  bool switchValueKcal = true;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    SizeConfig().init(context);
    int nr = 0;
    final horizonalBlock = SizeConfig.safeBlockHorizontal!;
    final verticalBlock = SizeConfig.safeBlockVertical!;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('settings')
            .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive();
          } else {
            if (snapshot.data!.docs[0]['Proteine'] == true && vitaminList.contains('Proteine') == false)
              vitaminList.add('Proteine');
            if (snapshot.data!.docs[0]['Proteine'] == false && vitaminList.contains('Proteine') == true)
              vitaminList.remove('Proteine');

            if (snapshot.data!.docs[0]['Vitamina C'] == true && vitaminList.contains('Vitamina C') == false)
              vitaminList.add('Vitamina C');
            if (snapshot.data!.docs[0]['Vitamina C'] == false && vitaminList.contains('Vitamina C') == true)
              vitaminList.remove('Vitamina C');

            if (snapshot.data!.docs[0]['Vitamina D'] == true && vitaminList.contains('Vitamina D') == false)
              vitaminList.add('Vitamina D');
            if (snapshot.data!.docs[0]['Vitamina D'] == false && vitaminList.contains('Vitamina D') == true)
              vitaminList.remove('Vitamina D');

            if (snapshot.data!.docs[0]['Vitamina E'] == true && vitaminList.contains('Vitamina E') == false)
              vitaminList.add('Vitamina E');
            if (snapshot.data!.docs[0]['Vitamina E'] == false && vitaminList.contains('Vitamina E') == true)
              vitaminList.remove('Vitamina E');

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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: verticalBlock * 2),
                      child: ListTile(
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
                    ),
                    ListTile(
                        title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('kcal', style: TextStyle(fontSize: verticalBlock * 2)),
                        CupertinoSwitch(
                          value: snapshot.data!.docs[0]['arataKcal'] == true,
                          onChanged: (value) {
                            updateSettings('arataKcal', value);
                            setState(() {
                              switchValueKcal = value;
                            });
                          },
                        ),
                      ],
                    )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalBlock * 2, horizontal: horizonalBlock * 4),
                      child: Text('Alege vitaminele tale deficitare:',
                          style: TextStyle(fontSize: verticalBlock * 2, fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: verticalBlock * 2),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vitamina D', style: TextStyle(fontSize: verticalBlock * 2)),
                          CupertinoSwitch(
                            value: snapshot.data!.docs[0]['Vitamina D'] == true,
                            onChanged: (value) {
                              updateSettings('Vitamina D', value);
                              setState(() {
                                switchValueD = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vitamina E', style: TextStyle(fontSize: verticalBlock * 2)),
                          CupertinoSwitch(
                            value: snapshot.data!.docs[0]['Vitamina E'] == true,
                            onChanged: (value) {
                              updateSettings('Vitamina E', value);
                              setState(() {
                                switchValueE = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vitamina C', style: TextStyle(fontSize: verticalBlock * 2)),
                          CupertinoSwitch(
                            value: snapshot.data!.docs[0]['Vitamina C'] == true,
                            onChanged: (value) {
                              updateSettings('Vitamina C', value);
                              setState(() {
                                switchValueC = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Proteine', style: TextStyle(fontSize: verticalBlock * 2)),
                          CupertinoSwitch(
                            value: snapshot.data!.docs[0]['Proteine'] == true,
                            onChanged: (value) {
                              updateSettings('Proteine', value);
                              setState(() {
                                switchValueP = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                body: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('recipe').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        finalList = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++)
                          if (vitaminList.contains(snapshot.data!.docs[i]['mainVitamin']))
                            finalList.add(Recipe.fromJSON((snapshot.data!.docs[i])));
                        return Stack(children: [
                          Positioned(
                              child:
                                  Container(height: verticalBlock * 40, color: blue, width: double.infinity)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: horizonalBlock * 10),
                                child: Text(
                                  "Retete pentru tine",
                                  style: TextStyle(fontSize: verticalBlock * 3.7, color: Colors.white),
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
                                  itemCount: finalList.length,
                                  itemBuilder: (context, index) {
                                    Recipe recipe = Recipe.fromJSON(snapshot.data!.docs[index]);
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
                                                  builder: (context) =>
                                                      RecipeDetail(recipe: finalList[index])),
                                            ),
                                            child: Image.asset(
                                              finalList[index].img,
                                              height: verticalBlock * 40,
                                            ),
                                          ),
                                          Text(finalList[index].name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: blue,
                                                fontSize: verticalBlock * 2.3,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          SizedBox(
                                            height: verticalBlock * 1.5,
                                          ),
                                          Text(finalList[index].mainVitamin,
                                              style: TextStyle(
                                                color: blue,
                                                fontSize: verticalBlock * 2.2,
                                              )),
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
                                  ...List.generate(finalList.length,
                                      (index) => Indicator(selectedIndex == index ? true : false)),
                                ],
                              )
                            ],
                          )
                        ]);
                      }
                    }));
          }
        });
  }
}
