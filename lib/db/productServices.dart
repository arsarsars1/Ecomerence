import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Model/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductServices {
  Firestore _fireStore = Firestore.instance;
  String products = 'products';

//  Future<List<Product>> getFeaturedProducts() => _fireStore
//          .collection(products)
//          .where('featured', isEqualTo: true)
//          .getDocuments()
//          .then((snap) {
//        List<Product> featuredProducts = [];
//        snap.documents.map(
//            (snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
//        print('featuredProducts');
//        Fluttertoast.showToast(
//            msg: "featuredProducts" + featuredProducts.length.toString());
//        print(featuredProducts.length.toString());
//        return featuredProducts;
//      });
}
