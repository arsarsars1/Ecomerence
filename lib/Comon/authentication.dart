import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAth {
  Future<FirebaseUser> googleSignIn();
}

class Auth implements BaseAth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    try {
      FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)) as FirebaseUser;
      return user;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
