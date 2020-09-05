import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/pages/productDetail.dart';
import 'package:economic/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return FutureBuilder(
      future: user.getPosts(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Loading(),
          );
        } else {
          return GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SingleProduct(
                    productName: snapshot.data[index].data['name'],
                    productPicture: snapshot.data[index].data['picture'],
                    productPrice: snapshot.data[index].data['price'],
                    sizes: snapshot.data[index].data['size'],
                    snapshot: snapshot.data[index],
                  ),
                );
              },
              itemCount: snapshot.data.length);
        }
      },
    );
  }

//  Future getPosts() async {
//    QuerySnapshot snapshot =
//    await Firestore.instance.collection(Common.Product).getDocuments();
//    return snapshot.documents;
//  }
}

class SingleProduct extends StatelessWidget {
  final productName;
  final productPicture;
  double productPrice;
  List sizes;
  DocumentSnapshot snapshot;

  SingleProduct(
      {this.productName,
      this.productPicture,
      this.snapshot,
      this.sizes,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: new Text(productName),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsDetail(
                            post: snapshot,
                          )));
            },
            child: GridTile(
              footer: Container(
                color: white,
                child: ListTile(
                  title: Text(
                    productName,
                    style: TextStyle(
                        color: black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "\$${productPrice}",
                    style: TextStyle(
                        color: red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              child: Image.network(
                productPicture,
//                fit: BoxFit.cover,
              ),

//              ListView(
//                padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                scrollDirection: Axis.vertical,
//                primary: false,
//                shrinkWrap: true,
//                children: sizes.map(
//                  (element) {
//                    return Text(
//                      element.toString(),
//                    );
//                  },
//                ).toList(),
//              ),
            ),
          ),
        ),
      ),
    );
  }
}
