import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/screens/all_recipe_screen.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/home_screen.dart';
import 'package:hackathon/screens/fav_recipes.screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final screens = [HomeScreen(), /*FavRecipes()*/ AllRecipeScreen()];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final verticalBlock = SizeConfig.safeBlockVertical!;
    final horizontalBlock = SizeConfig.safeBlockHorizontal!;
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cabin,
              size: verticalBlock * 2,
            ),
            activeIcon: Icon(
              Icons.cabin,
              size: verticalBlock * 2.5,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: verticalBlock * 2,
            ),
            activeIcon: Icon(
              Icons.favorite_border,
              size: verticalBlock * 2.5,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarm_outlined,
              size: verticalBlock * 2,
            ),
            activeIcon: Icon(
              Icons.access_alarm_outlined,
              size: verticalBlock * 2.5,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
