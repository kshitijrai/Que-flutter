import 'package:Que/screens/forgot_password/forgot_pass_screen.dart';
import 'package:Que/screens/home/home_screen.dart';
import 'package:Que/screens/login_success/login_success_screen.dart';
import 'package:Que/screens/sign_in/sign_in_screen.dart';
import 'package:Que/screens/sign_up/sign_up_screen.dart';
import 'package:Que/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

// using name route
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
