import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Cart_Products extends StatelessWidget {
  var Products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Dress1",
      "picture": "images/products/hills2.jpeg",
      "price": 85,
      "size": "7",
      "color": "Black",
      "quantity": 1,
    },
    {
      "name": "Blazer 1",
      "picture": "images/products/blazer2.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Dress1",
      "picture": "images/products/hills2.jpeg",
      "price": 85,
      "size": "7",
      "color": "Black",
      "quantity": 1,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_pro_name: Products_on_the_cart[index]["name"],
            cart_pro_picture: Products_on_the_cart[index]["picture"],
            cart_pro_price: Products_on_the_cart[index]["price"],
            cart_pro_size: Products_on_the_cart[index]["size"],
            cart_pro_color: Products_on_the_cart[index]["color"],
            cart_pro_qty: Products_on_the_cart[index]["quantity"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_pro_name;
  final cart_pro_picture;
  final cart_pro_price;
  final cart_pro_size;
  final cart_pro_color;
  final cart_pro_qty;

  Single_cart_product(
      {this.cart_pro_name,
      this.cart_pro_picture,
      this.cart_pro_price,
      this.cart_pro_size,
      this.cart_pro_color,
      this.cart_pro_qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // PICTURE
        leading: new Image.asset(
          cart_pro_picture,
          width: 80.0,
          height: 80.0,
        ),
        title: new Text(cart_pro_name),
        subtitle: new Column(
          children: <Widget>[
            //Row inside column
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    'cart_pro_size',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: new Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cart_pro_color,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),

            //Section is for the product price
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\$${cart_pro_price}",
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_drop_up, color: Colors.red),
                  iconSize: 100,
                  onPressed: () {}),
              Text(
                '$cart_pro_qty',
                style: TextStyle(fontSize: 65),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  iconSize: 100,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
