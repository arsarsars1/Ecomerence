import 'package:flutter/material.dart';

Color transparent = Colors.transparent;
Color pinkPurple = Colors.pink[900];
Color orange = Colors.deepOrange;
Color white70 = Colors.white70;
Color white = Colors.white;
Color black = Colors.black;
Color blue = Colors.blue;
Color grey = Colors.grey;
Color red = Colors.red;


void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context,
//                      PageTransition(type: PageTransitionType.rightToLeft, child: Admin()));
      MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

class Common{

  static const String Admin_email = 'arsarsars1@gmail.com';
  static const String Product = 'products';
  static const String Category = 'categories';
  static const String Brand = 'brands';
  static const String Order = 'orders';
  static const String Cart = 'cart';
  static const String User = 'User';

  static var userName = 'userName';
}