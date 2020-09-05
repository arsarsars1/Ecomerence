import 'package:economic/pages/home.dart';
import 'package:economic/pages/login.dart';
import 'package:economic/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=> UserProvider.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink[900]),
        home: ScreenController(),
      ),
    ),
  );
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
