import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/Model/cart.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/db/dbCart.dart';
import 'package:economic/pages/home.dart';
import 'package:economic/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: pinkPurple,
        title: Text("Cart"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: white,
              ),
              onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CartProductFetch(),
      ),
      bottomNavigationBar: Calculate(),
    );
  }
}

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  EServices eServices = EServices();
  double price = 0.0;
  String userId;

  Future getCartPrice(String uid) => Firestore.instance
          .collection(Common.User)
          .document(uid)
          .collection(Common.Cart)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });

//  @override
//  void initState() {
//    _getCategories();
//  }
//
//  _getCategories() async {
//    List<CartModel> data = await getCartPrice(userId);
//    Fluttertoast.showToast(msg: data.length.toString());
//    setState(() {
//      cartModel = data;
//    });
//  }

  void orderProduct(String uid, double price, List<CartModel> cartModel) {
    var id = Uuid();
    String orderId = id.v1();
    List<CartModel> cart = [];
//    Firestore.instance
//        .collection(Common.Order)
//        .document(orderId).setData({
//      'uid':uid,
//      'name':'Temp',
//      'cartModel':cart,
//      'totalPrice':price,
//      'id': orderId,
//    });

    for (int i = 0; i < cartModel.length; i++) {
      cart.add(cartModel[i]);
    }

    eServices.uploadOrder(
      cartModel: cart,
      uid: uid,
      name: 'Temp',
      totalPrice: price,
    );
    changeScreen(context, HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    setState(() {
      userId = user.user.uid;
    });
    return FutureBuilder(
      future: getCartPrice(user.user.uid),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Loading(),
          );
        } else {
          for (int i = 0; i < snapshot.data.length; i++) {
            price = price + snapshot.data[i].data['totalPrice'];
          }
          return snapshot.data.length == 0
              ? Container(
                  color: white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "No Item in Cart",
                            style: TextStyle(color: white),
                          ),
                          color: grey,
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  color: white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FinalStep(
                                          uid: user.user.uid,
                                          price: price,
                                        )));
//                            orderProduct(user.user.uid, price, user.cartModel);
                          },
                          child: Text(
                            "Check out: " + '\$$price',
                            style: TextStyle(color: white),
                          ),
                          color: pinkPurple,
                        ),
                      )
                    ],
                  ),
                );
        }
      },
    );
  }
}

class FinalStep extends StatefulWidget {
  String uid;
  double price;

  FinalStep({this.uid, this.price});

  @override
  _FinalStepState createState() => _FinalStepState();
}

class _FinalStepState extends State<FinalStep> {
  TextEditingController streetBlock = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController house = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: pinkPurple,
        title: Text("Address"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Please input your address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: city,
                          decoration: InputDecoration(hintText: "City"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter the city name';
                            } else if (value.length > 10) {
                              return 'Product name cant have more then 10 letters';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: town,
                          decoration: InputDecoration(hintText: "Town"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter the town name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: streetBlock,
                          decoration:
                              InputDecoration(hintText: "Street or Block"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter the town name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: house,
                          decoration: InputDecoration(hintText: "House no"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter the town name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: phoneNumber,
                          decoration: InputDecoration(hintText: "Phone Number"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter the town name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Container(
        color: white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new MaterialButton(
                onPressed: () {
                  confirmOrder();
                },
                child: Text(
                  "Confirm Order",
                  style: TextStyle(color: white),
                ),
                color: pinkPurple,
              ),
            )
          ],
        ),
      ),
    );
  }

  EServices eServices = EServices();
  List<CartModel> cartModel = [];

  Future<List<CartModel>> getCartData(uid) => Firestore.instance
          .collection(Common.User)
          .document(uid)
          .collection(Common.Cart)
          .getDocuments()
          .then((snap) {
        List<CartModel> data = [];
        for (DocumentSnapshot item in snap.documents) {
          CartModel cartModel = CartModel(
            totalPrice: item.data['totalPrice'],
            price: item.data['price'],
            quantity: item.data['quantity'],
            picture: item.data['picture'],
            uid: item.data['uid'],
            pid: item.data['pid'],
            brand: item.data['brand'],
            name: item.data['name'],
            category: item.data['category'],
          );
          data.add(cartModel);
        }
        return data;
      });

  _getCategories() async {
    List<CartModel> cart = await getCartData(widget.uid);

    for (int i = 0; i < cart.length; i++) {
      CartModel cartData = CartModel(
        totalPrice: cart[i].totalPrice,
        price: cart[i].price,
        quantity: cart[i].quantity,
        picture: cart[i].picture,
        uid: cart[i].uid,
        pid: cart[i].pid,
        brand: cart[i].brand,
        name: cart[i].name,
        category: cart[i].category,
      );
      cartModel.add(cartData);
    }
  }

  @override
  void initState() {
    _getCategories();
  }

  void confirmOrder() async {
    if (_formKey.currentState.validate() && cartModel.length != null) {
      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < cartModel.length; i++) {
        var id = Uuid();
        String orderId = id.v1();
        String cartId = id.v4();
        Firestore.instance.collection(Common.Order).document(orderId).setData({
          'uid': widget.uid,
          'name': Common.userName,
          'id': orderId,
          'city': city.text,
          'status': 0,
          'cartId': cartId,
          'time': DateTime.now().millisecondsSinceEpoch,
          'phoneNumber': phoneNumber.text,
          'town': town.text,
          'updatedTime': '0',
          'street': streetBlock.text,
          'house': house.text,
          'productName': cartModel[i].name,
          'brand': cartModel[i].brand,
          'category': cartModel[i].category,
          'quantity': cartModel[i].quantity,
          'pid': cartModel[i].pid,
          'picture': cartModel[i].picture,
          'totalPrice': cartModel[i].totalPrice,
          'price': cartModel[i].price,
        });
      }

      Firestore.instance
          .collection(Common.User)
          .document(widget.uid)
          .collection(Common.Cart)
          .getDocuments()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.documents) {
          doc.reference.delete();
        }
      }).then((onValue) => Fluttertoast.showToast(msg: 'Order done'));
//      setState(() {
//        isLoading = false;
//      });
      _formKey.currentState.reset();
      changeScreen(context, HomePage());
    } else {
      Fluttertoast.showToast(msg: 'Error');
    }
  }
}

class CartProductFetch extends StatelessWidget {
  Future getSuggestions(String uid, String email) => Firestore.instance
          .collection(Common.User)
          .document(uid)
          .collection(Common.Cart)
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
          return snapshot.data.length == 0
              ? Center(
                  child: InkWell(
                  onTap: () {
                    changeScreen(context, HomePage());
                  },
                  child: Text(
                    'Empty Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return SingleCartProduct(
                      productName: snapshot.data[index].data['name'],
                      productPicture: snapshot.data[index].data['picture'],
                      productPrice: snapshot.data[index].data['price'],
                      productQuantity: snapshot.data[index].data['quantity'],
                      totalPrice: snapshot.data[index].data['totalPrice'],
                      snapshot: snapshot.data[index],
                    );
                  },
                  itemCount: snapshot.data.length);
        }
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final productName;
  final productPicture;
  double productPrice;
  double totalPrice;
  int productQuantity;
  DocumentSnapshot snapshot;

  SingleCartProduct(
      {this.productName,
      this.productPicture,
      this.snapshot,
      this.totalPrice,
      this.productQuantity,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showAlertDialog(
              context, productName, snapshot.data['uid'], snapshot.data['pid']);
        },
        // PICTURE
        leading: Container(
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
        title: new Text(
          productName,
          style: TextStyle(
              fontSize: 13.0, fontWeight: FontWeight.bold, color: black),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            "Quantity: " + '$productQuantity',
            style: TextStyle(fontSize: 15),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Per Item ' + "\$${productPrice}",
              style: TextStyle(
                  fontSize: 13.0, fontWeight: FontWeight.bold, color: black),
            ),
            Text(
              'Total ' + "\$${totalPrice}",
              style: TextStyle(
                  fontSize: 15.0, fontWeight: FontWeight.bold, color: black),
            ),
          ],
        ),
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
