import 'package:economic/Comon/comon.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

////  final GoogleSignIn googleSignIn = new GoogleSignIn();
//  SharedPreferences preferences;
//  bool loading = false;
//  bool isLogedin = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
        key: _key,
        body: user.status == Status.Authenticating
            ? Loading()
            : Stack(
                children: <Widget>[
                  Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 100.0),
                                child: Text(
                                  "GatePay",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: pinkPurple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 50.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: grey.withOpacity(0.5),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _email,
                                    decoration: InputDecoration(
                                      hintText: "Email",
//                              labelText: "Email",
                                      icon: Icon(Icons.alternate_email),
//                              border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = new RegExp(pattern);
                                        if (!regex.hasMatch(value))
                                          return 'Please make sure your email address is valid';
                                        else
                                          return null;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: grey.withOpacity(0.5),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: TextFormField(
                                    controller: _password,
                                    decoration: InputDecoration(
//                              labelText: "Password",
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
//                              border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The password field cannot be empty";
                                      } else if (value.length < 6) {
                                        return "The password has to be at least 6 charaters long";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: pinkPurple.withOpacity(0.8),
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (!await user.signIn(
                                          _email.text, _password.text))
                                        _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Sign in failed"),
                                        ));
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Forgot password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Forgot Password",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: pinkPurple, fontSize: 18.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                    },
                                    child: Text(
                                      "Create an account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: pinkPurple, fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),

//                  Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Divider(),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text(
//                            "Or Login with",
//                            style: TextStyle(fontSize: 20, color: grey),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Divider(
//                            color: black,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Padding(
//                        padding:
//                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                        child: Material(
//                          child: MaterialButton(
//                            onPressed: () {},
//                            child: Image.asset(
//                              "images/facebook.png",
//                              width: 60,
//                            ),
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding:
//                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                        child: Material(
//                          child: MaterialButton(
//                            onPressed: () {},
//                            child: Image.asset(
//                              "images/google.png",
//                              width: 60,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
                          ],
                        )),
                  ),
//        Visibility(
//          visible: loading ?? true,
//          child: Center(
//            child: Container(
//              alignment: Alignment.center,
//              color: white.withOpacity(0.9),
//              child: CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(red),
//              ),
//            ),
//          ),
//        )
                ],
              ));
  }
}
