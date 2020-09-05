import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/components/horizontal_listview.dart';
import 'package:economic/pages/admin.dart';
import 'package:economic/pages/featured.dart';
import 'package:economic/pages/order.dart';
import 'package:economic/pages/singleProduct.dart';
import 'package:economic/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shoppingCart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  bool admin = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    if (user.user.email == Common.Admin_email) {
      admin = true;
    } else {
      admin = false;
    }

    StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection(Common.User)
          .document(user.user.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          return Common.userName = snapshot.data['name'];
        }
        return null;
      },
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: IconThemeData(color: pinkPurple),
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "The search field cannot be empty";
                }
                return null;
              },
            ),
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: pinkPurple,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: pinkPurple,
              ),
              onPressed: () {
                changeScreen(context, Cart());
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  Common.userName,
                  style:
                      TextStyle(color: pinkPurple, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  user.user.email,
                  style:
                      TextStyle(color: pinkPurple, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(color: transparent),
              ),
            ),
            //header
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: pinkPurple,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeScreen(context, HorizontalList());
              },
              child: ListTile(
                title: Text('Category'),
                leading: Icon(
                  Icons.category,
                  color: pinkPurple,
                ),
              ),
            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text('My account'),
//                leading: Icon(
//                  Icons.person,
//                  color: pinkPurple,
//                ),
//              ),
//            ),
            InkWell(
              onTap: () {
                changeScreen(context, Order());
              },
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: pinkPurple,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeScreen(context, Cart());
              },
              child: ListTile(
                title: Text('Shopping cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: pinkPurple,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourite'),
                leading: Icon(
                  Icons.favorite,
                  color: pinkPurple,
                ),
              ),
            ),
            Visibility(
              visible: admin,
              child: InkWell(
                onTap: () {
                  changeScreen(context, Admin());
                },
                child: ListTile(
                  title: Text('Admin'),
                  leading: Icon(
                    Icons.person_outline,
                    color: pinkPurple,
                  ),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text('About'),
//                leading: Icon(Icons.help),
//              ),
//            ),
            InkWell(
              onTap: () {
                user.signOut();
              },
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.transit_enterexit),
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 50.0, right: 50.0, top: 5.0, bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: pinkPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      color: white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Delievery in 40 minutes",
                      style: TextStyle(fontSize: 14.0, color: white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: pinkPurple,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.notifications_active,
                    color: white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "......",
                    style: TextStyle(fontSize: 14.0, color: white),
                  ),
                ],
              ),
            ),
          ),
          ImageCarousel(),
//          new Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Container(
//                alignment: Alignment.centerLeft, child: new Text('Category')),
//          ),
//          HorizontalList(),
          Row(
            children: <Widget>[
              Divider(),
              new Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      'Recent Products',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
          Flexible(child: Product()),
        ],
      ),
    );
  }
}
