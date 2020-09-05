import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServices {
//  FirebaseDatabase database = FirebaseDatabase.instance;
   Firestore database = Firestore.instance;

//  createUser(Map value) {
//    String id = value["userId"];
//    database
//        .reference()
//        .child("$ref/$id")
//        .set(value)
//        .catchError((e) => {print(e.toString())});
//  }
  void createUser(Map value) {
    String id = value["userId"];
    database
        .collection(Common.User)
    .document(id)
        .setData(value)
        .catchError((e) => {print(e.toString())});
  }


  Future<DocumentSnapshot> getData(userID) async {
// return await     Firestore.instance.collection('users').document(userID).get();
    DocumentSnapshot result =
    await Firestore.instance.collection('users').document(userID).get();
    return result;
  }
}
