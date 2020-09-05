import 'dart:async';

import 'package:economic/Model/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DatabaseTemp {
  static Future<String> createMountain() async {
    String accountKey = await _getAccountKey();

    var mountain = <String, dynamic>{
      'name': '',
      'created': _getDataNow(),
    };

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('products').push();

    reference.set(mountain);
    return reference.key;
  }

  static Future<void> saveName(String mountainKey,String name) async{
    return FirebaseDatabase.instance.reference().child('products')
        .child('name').set('01');
  }

  static Future<StreamSubscription<Event>> getNameStream(String mountainKey,void onData(String name)) async{
    StreamSubscription<Event> subscription  =  FirebaseDatabase.instance.reference().child('products').child('01')
        .child('name').onValue.listen((Event event){
          String name = event.snapshot.value as String;
          if(name == null){
            name  = "empty";
          }
          onData(name);
    });
    return subscription;
  }

}

String _getDataNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}

Future<String> _getAccountKey() async {
  return '123456789';
}
