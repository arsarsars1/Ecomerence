import 'package:economic/Comon/comon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedCategory extends StatefulWidget {
//  final DocumentSnapshot post;
//  SelectedCategory({this.post});

  @override
  _SelectedCategoryState createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkPurple,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: 125.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        color: white,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Healty',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Food',
                  style: TextStyle(
                    color: white,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 300.0,
                    child: ListView(
                      children: <Widget>[
                        _buildFoodItem('images/c1.jpg', 'foodName', '\$24.00'),
                        _buildFoodItem(
                            'images/m2.jpg', 'foodddmem2', '\$24.00'),
                        _buildFoodItem(
                            'images/c1.jpg', 'fobsjhem2', '\$245.00'),
                        _buildFoodItem(
                            'images/m2.jpg', 'foossaamem2', '\$254.00'),
                        _buildFoodItem('images/m1.jpeg', 'food2', '\$524.00'),
                        _buildFoodItem(
                            'images/w1.jpeg', 'foodName2', '\$254.00'),
                        _buildFoodItem('images/w3.jpeg', 'e2', '\$243.00'),
                        _buildFoodItem('images/w4.jpeg', 'fooe2', '\$124.00'),
                        _buildFoodItem('images/m1.jpeg', 'fooe2', '\$124.00'),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 65.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grey,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 65.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grey,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 65.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grey,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                          color: black,
                        ),
                        child: Center(
                            child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: white,
                            fontSize: 15.0,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
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
                        foodName,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        price,
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
            IconButton(
              icon: Icon(Icons.add),
              color: black,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
