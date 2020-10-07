import 'package:Que/refer/size_config.dart';
import 'package:Que/screens/home/home_screen.dart';

import 'package:Que/screens/splash/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAuth = false;

  signinAuth() {}
  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('1.User is currently signed out!');
        setState(() {
          isAuth = false;
        });
      } else {
        print('1.User is signed in!');
        setState(() {
          isAuth = true;
        });
      }
    });
  }

  Widget buildAuthScreen() {
    return HomeScreen();
  }

  Widget buildUnAuthScreen() {
    return Scaffold(body: Body());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
