import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future addToFavRecipes(String recipeName) async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection("favoriteRecipes");
  DocumentReference documentRecepies = collectionRef.doc(FirebaseAuth.instance.currentUser!.email);
  documentRecepies.get().then((docSnapshot) => {
        if (docSnapshot.exists)
          {
            documentRecepies.update({
              'favRecipes': FieldValue.arrayUnion([recipeName]),
              'id': FirebaseAuth.instance.currentUser!.email
            }),
          }
        else
          {
            documentRecepies.set({
              'favRecipes': [recipeName],
              'id': FirebaseAuth.instance.currentUser!.email
            }),
          }
      });
}

Future removeFromFavRecipes(String recipeName) async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection("favoriteRecipes");
  collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
    'favRecipes': FieldValue.arrayRemove([recipeName]),
  });
}

Future addStandardSettings() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection("settings");
  DocumentReference documentSettings = collectionRef.doc(FirebaseAuth.instance.currentUser!.email);
  documentSettings.set({
    'Vitamina D': false,
    'Vitamina C': false,
    'Vitamina E': false,
    'Proteine': false,
    'arataKcal': true,
    'id': FirebaseAuth.instance.currentUser!.email
  });
}

Future updateSettings(String settingName, bool value) async {
  final collectionRef = FirebaseFirestore.instance.collection('settings');
  return collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({settingName: value});
}

Future<void> removeFavAlert(BuildContext context, String recipeName) async {
  Platform.isAndroid
      ? showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Esti sigur ca vrei sa stergi reteta din favorite?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Nu"),
                  ),
                  TextButton(
                    onPressed: () => removeFromFavRecipes(recipeName),
                    child: const Text("Da"),
                  ),
                ],
              ))
      : showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text("Esti sigur ca vrei sa stergi reteta din favorite?"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("Nu"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: const Text("Da"),
                    onPressed: () {
                      removeFromFavRecipes(recipeName);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
}
