import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductServices {
  Firestore _fireStore = Firestore.instance;
  String ref = 'products';

  void uploadProduct(
      {String productName,
      String brandName,
      String category,
      int quantity,
      List size,
        String details,
//      List images,
      String picture,
        bool feature,
        bool sale,
      double price}) {
    var id = Uuid();
    String productId = id.v1();
    _fireStore.collection(ref).document(productId).setData({
      'name': productName,
      'brand': brandName,
      'category': category,
      'quantity': quantity,
      'details':details,
      'size': size,
      'sale':sale,
      'feature':feature,
      'picture': picture,
      'price': price,
      'id': productId,
    });
  }
}
