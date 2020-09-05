import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/Model/cart.dart';
import 'package:economic/Model/product.dart';
import 'package:uuid/uuid.dart';

class EServices {
  Firestore _fireStore = Firestore.instance;

  void uploadCart(
      {String productName,
        String brandName,
        String category,
        int quantity,
        String pId,
        String uid,
        String picture,
        double totalPrice,
        double price}) {
    _fireStore.collection(Common.User).document(uid).collection(Common.Cart).document(pId).setData({
      'name': productName,
      'uid':uid,
      'brand': brandName,
      'category': category,
      'quantity': quantity,
      'pid': pId,
      'picture': picture,
      'totalPrice':totalPrice,
      'price': price,
    });
  }

//  void uploadOrder(
//      {String productName,
//        String brandName,
//        String category,
//        int quantity,
//        String pId,
//        String uid,
//        String picture,
//        double totalPrice,
//        double price}) {
//    var id = Uuid();
//    String orderId = id.v1();
//    _fireStore.collection(Common.Order).document(orderId).setData({
//      'name': productName,
//      'uid':uid,
//      'brand': brandName,
//      'category': category,
//      'quantity': quantity,
//      'pid': pId,
//      'picture': picture,
//      'totalPrice':totalPrice,
//      'price': price,
//      'cId': orderId,
//    });
//  }

  void uploadOrder(
      {
        List cartModel,
        String uid,
        String name,
        double totalPrice
      }) {
    var id = Uuid();
    String orderId = id.v1();
    _fireStore.collection(Common.Order).document(orderId).setData({
      'uid':uid,
      'name':name,
      'cartModel':cartModel,
      'totalPrice':totalPrice,
      'id': orderId,
    });
  }
}
