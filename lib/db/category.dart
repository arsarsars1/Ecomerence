import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryServices {
  Firestore _fireStore = Firestore.instance;
  String ref = 'categories';

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();
    _fireStore.collection(ref).document(categoryId).setData({'category': name});
  }

  Future<List<DocumentSnapshot>> getCategories() =>
      _fireStore.collection(ref).getDocuments().then((snaps) {
        return snaps.documents;
      });

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _fireStore
          .collection(ref)
          .where('category', isEqualTo: suggestion)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });
}
