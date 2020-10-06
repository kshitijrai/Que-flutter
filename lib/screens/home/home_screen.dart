import 'package:Que/components/default_button.dart';
import 'package:Que/refer/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Text("Home Page, to be built"),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: 'Sign Out',
              press: () async {
                Text("Sign out");
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
