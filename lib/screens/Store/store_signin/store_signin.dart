import 'package:Que/screens/Store/store_signin/components/body.dart';
import 'package:flutter/material.dart';

class StoreSignin extends StatelessWidget {
  static String routeName = '/store_sign_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Sign In"),
      ),
      body: SingleChildScrollView(child: Body()),
    );
  }
}
