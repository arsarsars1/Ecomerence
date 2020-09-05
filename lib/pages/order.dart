import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/pages/home.dart';
import 'package:economic/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: pinkPurple,
        title: Text("Order"),
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
        child: OrderProductFetch(),
      ),
    );
  }
}

class OrderProductFetch extends StatelessWidget {
  Future getSuggestions(String uid) => Firestore.instance
          .collection(Common.Order)
          .where('uid', isEqualTo: uid)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return FutureBuilder(
      future: getSuggestions(user.user.uid),
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
                      'No Order yet\n Click here to buy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return SingleOrder(
                      snapshot: snapshot.data[index],
                    );
                  },
                  itemCount: snapshot.data.length);
        }
      },
    );
  }
}

class SingleOrder extends StatelessWidget {
  double _fontSize = 18;
  DocumentSnapshot snapshot;

  SingleOrder({this.snapshot});

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('yyyy-MM-dd \n hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  String convertStatus(int status) {
    switch (status) {
      case 0:
        return 'In Pending';
        break;
      case 1:
        return 'Order Confirmed';
        break;
      case 2:
        return 'In Progress';
        break;
      case 3:
        return 'Transit';
        break;
      case 4:
        return 'Delievered';
        break;
      case 5:
        return 'Order Cancelled';
        break;
      case 6:
        return 'Out of Stock';
        break;
      default:
        return 'Error';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String date = readTimestamp(snapshot.data['time']);
    String status = convertStatus(snapshot.data['status']);
    return Card(
      child: ListTile(
        onTap: () {
          // item display
        },
        onLongPress: () {
          showAlertDialog(
              context, snapshot.data['productName'], snapshot.data['id']);
        },
        // PICTURE
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: <Widget>[
              Text(
                'Order no: ',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: black),
              ),
              Expanded(
                child: Text(
                  snapshot.data['cartId'],
                  style: TextStyle(fontSize: 15, color: black),
                ),
              ),
            ],
          ),
        ),
        subtitle: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      snapshot.data['productName'],
                      style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    Expanded(
                      child: Text(
                        ' (' + snapshot.data['brand'] + ')',
                        style: TextStyle(fontSize: _fontSize, color: black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Name: ",
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data['name'],
                          style: TextStyle(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Phone Number: ",
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data['phoneNumber'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Address: ",
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data['house'] +
                              ', ' +
                              snapshot.data['street'] +
                              ',' +
                              snapshot.data['town'] +
                              ', ' +
                              snapshot.data['city'],
                          style: TextStyle(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Order Time: ",
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      Expanded(
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Order Status: ",
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      Expanded(
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.bold,
                            color: black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                updatedTime(),
              ],
            ),
          ),
        ),
        trailing: Column(
          children: <Widget>[
            Expanded(
              child: Text(
                snapshot.data['price'].toString() +
                    ' x ' +
                    snapshot.data['quantity'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _fontSize, color: black),
              ),
            ),
            Text(
              '| |',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: black),
            ),
            Expanded(
              child: Text(
                'Rs:' + snapshot.data['totalPrice'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String productName, String id) {
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
        removeProduct(id, context);
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

  void removeProduct(String id, BuildContext context) {
    try {
      Firestore.instance.collection(Common.Order).document(id).delete();
      changeScreen(context, HomePage());
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error in network');
    }
  }

  Widget updatedTime() {
    if (snapshot.data['updatedTime'] == '0') {
      return Container();
    } else {
      String time = readTimestamp(snapshot.data['updatedTime']);
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              "Last updated: ",
              style: TextStyle(fontSize: 16),
            ),
            Expanded(
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
