import 'package:Que/screens/sign_in/sign_in_screen.dart';
import 'package:Que/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

// using name route
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
};
