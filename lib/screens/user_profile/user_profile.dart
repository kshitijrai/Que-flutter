import 'package:Que/components/default_button.dart';
import 'package:Que/refer/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
      child: Column(children: [
        Text('User Profile Page tbb'),
        Spacer(),
        DefaultButton(
          text: 'Sign Out',
          press: () async {
            Text("Sign out");
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        )
      ]),
    ));
  }
}
