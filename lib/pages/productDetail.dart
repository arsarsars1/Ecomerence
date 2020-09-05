import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/db/dbCart.dart';
import 'package:economic/provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductsDetail extends StatefulWidget {
  final DocumentSnapshot post;

  ProductsDetail({this.post});

  @override
  _ProductsDetailState createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  EServices cartServices = EServices();
  int quantity = 1;
  double totalPrice = 0;
  bool isLoading = false;

  void _incrementCounter() {
    setState(() {
      quantity++;
//      quantity = quantity < widget.post.data['quantity']
//          ? ++quantity
//          : 1; //in replace of 1 => widget.post.data['quantity']
    });

    setState(() {
      totalPrice = quantity * widget.post.data['price'];
    });
  }

  void _decrementCounter() {
    setState(() {
      quantity--;
//      quantity = quantity > 1 ? --quantity : 1;
    });

    setState(() {
      totalPrice = quantity * widget.post.data['price'];
    });
  }

  void _calculatePrice() {
    setState(() {
      totalPrice = quantity * widget.post.data['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    _calculatePrice();
    return Scaffold(
      backgroundColor: pinkPurple,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: transparent,
        elevation: 0.0,
        title: Text(
          'Details',
          style: TextStyle(
            fontSize: 18.0,
            color: white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: white,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: transparent,
              ),
              Positioned(
                top: 75.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: white,
                  ),
                  height: MediaQuery.of(context).size.height - 100.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                  tag: widget.post.data['name'],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35.0),
                      ),
                      color: black.withOpacity(0.2),
                      image: DecorationImage(
                        image: NetworkImage(widget.post.data['picture']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
              ),
              Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.post.data['name'],
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "\$${widget.post.data['price']}",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 25.0,
                          color: grey,
                          width: 1.0,
                        ),
                        Container(
                          width: 125.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            color: pinkPurple,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _decrementCounter();
                                },
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: white,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: black,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '$quantity',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 15.0,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _incrementCounter();
                                },
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: white,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: black,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
//                    SizedBox(
//                      height: 10.0,
//                    ),
//                    GridView.count(crossAxisCount: 3,
//                    crossAxisSpacing: 4,
//                    mainAxisSpacing: 4,
//                    children: widget.post.data['size'].map((size)=>).toList() ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 337.0,
                      child: Text(
                        widget.post.data['details'],
                        style: TextStyle(
                          color: black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),

                    SizedBox(height: 5.0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: white,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0, right: 10, left: 10),
          child: InkWell(
            onTap: () {
              uploadToCart(user.user.uid);
            },
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
                child: isLoading
                    ? Center(child: Loading())
                    : Text(
                        "\$$totalPrice",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadToCart(String uid) async {
    setState(() {
      isLoading = true;
    });
    cartServices.uploadCart(
      productName: widget.post.data['name'],
      brandName: widget.post.data['brand'],
      quantity: quantity,
      totalPrice: totalPrice,
      price: widget.post.data['price'],
      picture: widget.post.data['picture'],
      pId: widget.post.data['id'],
      category: widget.post.data['category'],
      uid: uid,
    );

    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(msg: 'Product added to Cart');
    Navigator.pop(context);
  }
}
