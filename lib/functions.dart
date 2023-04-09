import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
