import 'package:economic/Comon/comon.dart';
import 'package:economic/components/loading.dart';
import 'package:economic/db/user.dart';
import 'package:economic/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  UserServices userServices = UserServices();
  String gender = "male";
  bool hidePass = true;
  String groupValue = "male";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Container(
//              alignment: Alignment.topCenter,
//              child: Image.asset(
//                'images/background.jpeg',
//                width: 120.0,
//              ),
//            ),
//          ),
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
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
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: grey.withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _name,
                                    decoration: InputDecoration(
                                      hintText: "Full name",
//                                  labelText: "Full name",
                                      icon: Icon(Icons.person_outline),
//                              border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The name field cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: grey.withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                      hintText: "Email",
//                                  labelText: "Email",
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
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "male",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: black),
                                      ),
                                      trailing: Radio(
                                          value: "male",
                                          groupValue: groupValue,
                                          onChanged: (e) => valueChanged(e)),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "female",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: black),
                                      ),
                                      trailing: Radio(
                                          value: "female",
                                          groupValue: groupValue,
                                          onChanged: (e) => valueChanged(e)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: grey.withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _password,
                                    obscureText: hidePass,
                                    decoration: InputDecoration(
                                      hintText: "Password",
//                                  labelText: "Password",
                                      icon: Icon(Icons.lock_outline),
//                              border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The password field cannot be empty";
                                      } else if (value.length < 6) {
                                        return "the password has to be at least 6 characters long";
                                      }
                                      return null;
                                    },
                                  ),
                                  trailing: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          if (hidePass) {
                                            hidePass = false;
                                          } else {
                                            hidePass = true;
                                          }
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
//                        Padding(
//                          padding:
//                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                          child: Material(
//                            borderRadius: BorderRadius.circular(10.0),
//                            color: grey.withOpacity(0.4),
//                            elevation: 0.0,
//                            child: Padding(
//                              padding: const EdgeInsets.all(5.0),
//                              child: ListTile(
//                                title: TextFormField(
//                                  controller: _confirmPasswordController,
//                                  obscureText: hidePass,
//                                  decoration: InputDecoration(
//                                    hintText: "Confirm password",
////                                  labelText: "Confirm password",
//                                    icon: Icon(Icons.lock_outline),
////                                    border: InputBorder.none,
////                              border: OutlineInputBorder(),
//                                  ),
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return "The password field cannot be empty";
//                                    } else if (value.length < 6) {
//                                      return "the password has to be at least 6 characters long";
//                                    } else if (_passwordTextController.text !=
//                                        value) {
//                                      return "the passwords do not match";
//                                    }
//                                    return null;
//                                  },
//                                ),
//                                trailing: IconButton(
//                                    icon: Icon(Icons.remove_red_eye),
//                                    onPressed: () {
//                                      setState(() {
//                                        hidePass = false;
//                                      });
//                                    }),
//                              ),
//                            ),
//                          ),
//                        ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: pinkPurple,
                                elevation: 0.0,
                                child: MaterialButton(
//                            onPressed: () async {
//                              validateForm();
//                            },
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (!await user.signUp(
                                          _name.text,
                                          gender,
                                          "13/07/1997",
                                          _email.text,
                                          _password.text))
                                        _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Sign up failed"),
                                        ));
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Sign up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "I already have an account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: pinkPurple, fontSize: 18.0),
                                  ))),
//                    Padding(
//                      padding: const EdgeInsets.all(10.0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Divider(),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              "Or SignUp with",
//                              style: TextStyle(fontSize: 20, color: grey),
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Divider(
//                              color: black,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Padding(
//                          padding:
//                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                          child: Material(
//                            child: MaterialButton(
//                              onPressed: () {},
//                              child: Image.asset(
//                                "images/facebook.png",
//                                width: 60,
//                              ),
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding:
//                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                          child: Material(
//                            child: MaterialButton(
//                              onPressed: () async{
//                                FirebaseUser user = await auth.googleSignIn();
//                                if(user == null){
//                                  userServices.createUser({
//                                    "name":user.displayName,
//                                    "photo":user.photoUrl,
//                                    "email":user.email,
//                                    "userId":user.uid
//                                  });
//                                  changeScreenReplacement(context, HomePage());
//                                }
//                              },
//                              child: Image.asset(
//                                "images/google.png",
//                                width: 60,
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
                        ],
                      )),
                ),
//          Visibility(
//            visible: loading ?? true,
//            child: Center(
//              child: Container(
//                alignment: Alignment.center,
//                color: white.withOpacity(0.9),
//                child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(red),
//                ),
//              ),
//            ),
//          )
              ],
            ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future<void> validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text)
            .then((user) => {
                  userServices.createUser({
                    "username": _name.text,
                    "email": _email.text,
                    "userId": user.user.uid.toString(),
                    "gender": gender,
                  })
                })
            .catchError((err) => {Fluttertoast.showToast(msg: err.toString())});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => new HomePage()));
      }
    }
  }
}
