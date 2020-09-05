import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economic/Comon/comon.dart';
import 'package:economic/Model/cart.dart';
import 'package:economic/db/dbCart.dart';
import 'package:economic/db/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth auth;
  FirebaseUser _user;
  Firestore _fireStore = Firestore.instance;
  DocumentReference userData;
  EServices eServices = EServices();
  Status _status = Status.Uninitialized;
  UserServices userServices = UserServices();
  List<DocumentSnapshot> photosData = <DocumentSnapshot>[];

//  List<CartModel> cartModel = [];

  Status get status => _status;

  FirebaseUser get user => _user;

  UserProvider.initialize() : auth = FirebaseAuth.instance {
    auth.onAuthStateChanged.listen(onStateChnaged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String gender, String birthday, String email,
      String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Map<String, dynamic> values = {
          "name": name,
          "email": email,
          "type": Common.User,
          "userId": user.user.uid,
          "gender": gender,
          "birthday": birthday
        };
        userServices.createUser(values);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<List<DocumentSnapshot>> getFeaturedPictures() => _fireStore
          .collection(Common.Product)
          .where('feature', isEqualTo: true)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });

  Future getPosts() async {
    QuerySnapshot snapshot =
        await _fireStore.collection(Common.Product).getDocuments();
    return snapshot.documents;
  }

  DocumentReference getClientProfile() {
    return _fireStore.collection(Common.User).document(user.uid);
  }

  Future getUser() async {
    DocumentReference snapshot =
    _fireStore.collection(Common.User).document(user.uid);
    return snapshot;
  }

  Future<List<CartModel>> getCartData() async => _fireStore
          .collection(Common.User)
          .document(user.uid)
          .collection(Common.Cart)
          .getDocuments()
          .then((snap) {
        List<CartModel> data = [];
        for (DocumentSnapshot item in snap.documents) {
          CartModel cartModel = CartModel(
            totalPrice: item.data['totalPrice'],
            price: item.data['price'],
            quantity: item.data['quantity'],
            picture: item.data['picture'],
            uid: item.data['uid'],
            pid: item.data['pid'],
            brand: item.data['brand'],
            name: item.data['name'],
            category: item.data['category'],
          );
          data.add(cartModel);
        }
        return data;
      });

  Future<void> onStateChnaged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
      photosData = await getFeaturedPictures();
      userData = await getUser();

//      cartModel = await eServices.getCartData(user.uid);
    }
    notifyListeners();
  }
}
