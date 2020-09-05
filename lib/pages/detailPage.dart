import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/db/dbCart.dart';
import 'package:economic/pages/home.dart';
import 'package:economic/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> selectedSizes = <String>[];
  EServices cartServices = EServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: pinkPurple,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new HomePage()));
            },
            child: Text(widget.post.data['name'])),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(
                  widget.post.data['picture'].toString(),
                ),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.post.data['name'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text("\$${widget.post.data['price']}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0))),
                      Expanded(
                          child: new Text("\$${widget.post.data['price']}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)))
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ========== first Button =======
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: MaterialButton(
//                  onPressed: () {
//                    showDialog(
//                        context: context,
//                        builder: (context) {
//                          return new AlertDialog(
//                            title: new Text("Size"),
//                            content: new Text("Choose the size"),
//                            actions: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Checkbox(
//                                    value: selectedSizes.contains('38'),
//                                    onChanged: (value) => changeSelectedSize('38'),
//                                  ),
//                                  Text('38'),
//                                  Checkbox(
//                                    value: selectedSizes.contains('40'),
//                                    onChanged: (value) => changeSelectedSize('40'),
//                                  ),
//                                  Text('40'),
//                                  Checkbox(
//                                    value: selectedSizes.contains('42'),
//                                    onChanged: (value) => changeSelectedSize('42'),
//                                  ),
//                                  Text('42'),
//                                  Checkbox(
//                                    value: selectedSizes.contains('48'),
//                                    onChanged: (value) => changeSelectedSize('48'),
//                                  ),
//                                  Text('48'),
//                                  Checkbox(
//                                    value: selectedSizes.contains('50'),
//                                    onChanged: (value) => changeSelectedSize('50'),
//                                  ),
//                                  Text('50'),
//                                ],
//                              ),
//                              new MaterialButton(
//                                onPressed: () {
//                                  Navigator.of(context).pop(context);
//                                },
//                                child: new Text("close"),
//                              )
//                            ],
//                          );
//                        });
//                  },
//                  color: Colors.white,
//                  textColor: Colors.grey,
//                  elevation: 0.2,
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: new Text("Size"),
//                      ),
//                      Expanded(
//                        child: new Icon(Icons.arrow_drop_down),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Expanded(
//                child: MaterialButton(
//                  onPressed: () {
//                    showDialog(
//                        context: context,
//                        builder: (context) {
//                          return new AlertDialog(
//                            title: new Text("Colors"),
//                            content: new Text("Choose a color"),
//                            actions: <Widget>[
//                              new MaterialButton(
//                                onPressed: () {
//                                  Navigator.of(context).pop(context);
//                                },
//                                child: new Text("close"),
//                              )
//                            ],
//                          );
//                        });
//                  },
//                  color: Colors.white,
//                  textColor: Colors.grey,
//                  elevation: 0.2,
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: new Text("Color"),
//                      ),
//                      Expanded(
//                        child: new Icon(Icons.arrow_drop_down),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              Expanded(
//                child: MaterialButton(
//                  onPressed: () {
//                    showDialog(
//                        context: context,
//                        builder: (context) {
//                          return new AlertDialog(
//                            title: new Text("Quantity"),
//                            content: new Text("Choose the quantity"),
//                            actions: <Widget>[
//                              new MaterialButton(
//                                onPressed: () {
//                                  Navigator.of(context).pop(context);
//                                },
//                                child: new Text("close"),
//                              )
//                            ],
//                          );
//                        });
//                  },
//                  color: Colors.white,
//                  textColor: Colors.grey,
//                  elevation: 0.2,
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: new Text("Qty"),
//                      ),
//                      Expanded(
//                        child: new Icon(Icons.arrow_drop_down),
//                      )
//                    ],
//                  ),
//                ),
//              )
//            ],
//          ),

          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: pinkPurple,
                  textColor: white,
                  elevation: 0.2,
                  child: new Text("Buy now"),
                ),
              ),
              new IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: pinkPurple,
                  ),
                  onPressed: () {
                    cartServices.uploadCart(
                      productName: widget.post.data['name'],
                      brandName: widget.post.data['brand'],
                      quantity: widget.post.data['quantity'],
                      price: widget.post.data['price'],
                      picture: widget.post.data['picture'],
                      pId: widget.post.data['id'],
                      category: widget.post.data['category'],
                      uid: user.user.uid,
                    );
                  }),
            ],
          ),
          Divider(
//            color: Colors.grey,
              ),
          new ListTile(
            title: new Text("Product details"),
            subtitle: new Text(widget.post.data['details']),
          ),
          Divider(
//            color: Colors.grey,
              ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.post.data['name']),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.post.data['brand']),
              )
            ],
          ),
        ],
      ),
    );
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }
}
