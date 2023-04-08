import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/model/recipes_model.dart';

class FavRecipes extends StatelessWidget {
  FavRecipes({super.key});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
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
                return ListView.builder(
                    itemCount: snapshot.data!.docs[0]['favRecipes'].length,
                    itemBuilder: ((context, index) {
                      //FavRecipes favRecipes = FavRecipes.fromJSON(snapshot.data!.docs[index]);

                      return Container();
                    }));
              }
            }));
  }
}
