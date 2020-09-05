import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:flutter/material.dart';

class DeleteDataFromFireStore extends StatelessWidget {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Data from Firestore")),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection(Common.Product).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        title: Text(doc.data['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () async {
                            await db
                                .collection(Common.Product)
                                .document(doc.documentID)
                                .delete();
                          },
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
    );
  }
}