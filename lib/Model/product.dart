import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product {
  static const String BRAND = 'brand';
  static const String CATEGORY = 'category';
  static const String COLORS = 'colors';
  static const String FEATURED = 'featured';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PICTURE = 'picture';
  static const String PRICE = 'price';
  static const String QUANTITY = 'quantity';
  static const String SALE = 'sale';
  static const String SIZE = 'size';

//  String _brand;
//  String _category;
//  List<String> _colors;
//  bool _featured;
//  String _id;
//  String _name;
//  String _picture;
//  double _price;
//  int _quantity;
//  bool _sale;
//  List<String> _size;

  final String brand;
  final String category;
  final List<String> colors;
  final bool feature;
  final String id;
  final String name;
  final String details;
  final String picture;
  final double price;
  final int quantity;
  final bool sale;
  final List<String> size;

  Product(
      {@required this.brand,
      @required this.category,
      @required this.colors,
      @required this.feature,
      @required this.id,
      @required this.name,
      @required this.details,
      @required this.picture,
      @required this.price,
      @required this.quantity,
      @required this.sale,
      @required this.size});

//  String get brand => _brand;
//
//  String get category => _category;
//
//  List<String> get size => _size;
//
//  bool get sale => _sale;
//
//  int get quantity => _quantity;
//
//  double get price => _price;
//
//  String get picture => _picture;
//
//  String get name => _name;
//
//  String get id => _id;
//
//  bool get featured => _featured;
//
//  List<String> get colors => _colors;

//  Product.fromMap(Map<String, dynamic> data) {
//    _brand = data[BRAND];
//    _category = data[CATEGORY];
//    _colors = data[COLORS];
//    _featured = data[FEATURED];
//    _id = data[ID];
//    _name = data[NAME];
//    _picture = data[PICTURE];
//    _price = data[PRICE];
//    _quantity = data[QUANTITY];
//    _sale = data[SALE];
//    _size = data[SIZE];
//  }
//
//  Product.fromSnapshot(DocumentSnapshot snapshot) {
//    Map data = snapshot.data;
//    _brand = data[BRAND];
//    _category = data[CATEGORY];
//    _colors = data[COLORS];
//    _featured = data[FEATURED];
//    _id = data[ID];
//    _name = data[NAME];
//    _picture = data[PICTURE];
//    _price = data[PRICE];
//    _quantity = data[QUANTITY];
//    _sale = data[SALE];
//    _size = data[SIZE];
//  }
}
