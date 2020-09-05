import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartModel {
  String brand;
  String category;
  String name;
  String picture;
  String pid;
  String uid;
  double price;
  int quantity;
  double totalPrice;

  CartModel(
      {@required this.brand,
        @required this.category,
        @required this.name,
        @required this.picture,
        @required this.pid,
        @required this.price,
        @required this.quantity,
        @required this.totalPrice,
        @required this.uid});

//  static const String BRAND = 'brand';
//  static const String CATEGORY = 'category';
//  static const String COLORS = 'colors';
//  static const String FEATURED = 'featured';
//  static const String UID = 'uid';
//  static const String PID = 'pid';
//  static const String NAME = 'name';
//  static const String PICTURE = 'picture';
//  static const String PRICE = 'price';
//  static const String QUANTITY = 'quantity';
//  static const String SALE = 'sale';
//  static const String TotalPrice = 'totalPrice';
//  static const String SIZE = 'size';
//
//  String _brand;
//  String _category;
//  String _name;
//  String _picture;
//  String _pid;
//  double _price;
//  int _quantity;
//  double _totalPrice;
//  String _uid;
//
//  String get brand => _brand;
//
//  String get category => _category;
//
//  String get name => _name;
//
//  String get picture => _picture;
//
//  String get pid => _pid;
//
//  double get price => _price;
//
//  int get quantity => _quantity;
//
//  double get totalPrice => _totalPrice;
//
//  String get uid => _uid;
//
//  CartModel.fromSnapshot(DocumentSnapshot snapshot) {
//    Map data = snapshot.data;
//    _brand = data[BRAND];
//    _category = data[CATEGORY];
//    _name = data[NAME];
//    _picture = data[PICTURE];
//    _pid = data[PID];
//    _uid = data[UID];
//    _price = data[PRICE];
//    _quantity = data[QUANTITY];
//    _totalPrice = data[TotalPrice];
//  }
}
