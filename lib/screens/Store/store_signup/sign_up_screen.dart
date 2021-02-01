import 'package:Que/screens/Store/store_signup/components/body.dart';
import 'package:flutter/material.dart';

class StoreSignUpScreen extends StatelessWidget {
  static String routeName = "/store_signup";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Sign Up"),
      ),
      body: SingleChildScrollView(child: Body()),
    );
  }
}
