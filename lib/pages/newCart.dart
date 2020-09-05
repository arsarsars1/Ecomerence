import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/pages/home.dart';
import 'package:economic/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NewCart extends StatefulWidget {
  @override
  _NewCartState createState() => _NewCartState();
}

class _NewCartState extends State<NewCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Details',
            style: TextStyle(
                fontFamily: 'Cart', fontSize: 18.0, color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.white,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'Cart',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 45.0),
                  child: CartProductFetch(),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0)),
                  color: Colors.black),
              height: 50.0,
              child: Center(
                child: Text('\$52.00',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Montserrat')),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_back_ios),
          title: Padding(
            padding: EdgeInsets.all(0),
            child: Text('Back'),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward_ios),
          title: Padding(
            padding: EdgeInsets.all(0),
            child: Text('Checkout'),
          ),
        ),
      ], type: BottomNavigationBarType.fixed),
    );
  }
}

class CartProductFetch extends StatelessWidget {
  Future getSuggestions(String uid, String email) => Firestore.instance
          .collection(Common.User)
          .document(uid)
          .collection(Common.Cart)
          .where('mail', isEqualTo: email)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return FutureBuilder(
      future: getSuggestions(user.user.uid, user.user.email),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Loading(),
          );
        } else {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SingleCart(
                    productName: snapshot.data[index].data['name'],
                    productPicture: snapshot.data[index].data['picture'],
                    productPrice: snapshot.data[index].data['price'],
                    productQuantity: snapshot.data[index].data['quantity'],
                    totalPrice: snapshot.data[index].data['totalPrice'],
                    snapshot: snapshot.data[index],
                  ),
                );
              },
              itemCount: snapshot.data.length);
        }
      },
    );
  }
}

class SingleCart extends StatelessWidget {
  final productName;
  final productPicture;
  double productPrice;
  double totalPrice;
  int productQuantity;
  DocumentSnapshot snapshot;

  SingleCart(
      {this.productName,
      this.productPicture,
      this.snapshot,
      this.productQuantity,
      this.totalPrice,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: black.withOpacity(0.2),
                    image: DecorationImage(
                      image: NetworkImage(productPicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 75.0,
                  width: 75.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$$productPrice',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Quanity: ' + '$productQuantity',
                    style: TextStyle(
                      color: black,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    'Total Price ' + '$totalPrice',
                    style: TextStyle(
                      color: black,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  showAlertDialog(context, productName, snapshot.data['uid'],
                      snapshot.data['pid']);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  showAlertDialog(
      BuildContext context, String productName, String id, String pid) {
    // set up the button
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        removeProduct(id, pid, context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Remove Item'),
      content: Text('Are you sure to remove ' + productName + ' from cart'),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void removeProduct(String id, String pid, BuildContext context) {
    try {
      Firestore.instance
          .collection(Common.User)
          .document(id)
          .collection(Common.Cart)
          .document(pid)
          .delete();
      changeScreen(context, HomePage());
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error in network');
    }
  }
}
