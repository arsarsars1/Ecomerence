import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandServices {
  Firestore _fireStore = Firestore.instance;
  String ref = 'brands';

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _fireStore.collection(ref).document(brandId).setData({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _fireStore.collection(ref).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _fireStore
          .collection(ref)
          .where('brand', isEqualTo: suggestion)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });
}
