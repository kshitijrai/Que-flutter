import 'package:Que/components/manage_store.dart';
import 'package:Que/components/no_account.dart';
import 'package:Que/components/social_card.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:Que/screens/sign_in/components/signin_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signInWithGoogle() async {
      await Firebase.initializeApp();

      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleUser.authentication;
        GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );
        FirebaseAuth _auth = FirebaseAuth.instance;
        await _auth.signInWithCredential(credential);
        User user = _auth.currentUser;
        if (user != null) {
          DocumentReference users = FirebaseFirestore.instance
              .collection('users')
              .doc(googleUser.email);
          print(user.uid);
          return users
              .set({
                'user_id': user.uid,
                'full_name': googleUser.displayName,
                'email': googleUser.email,
              })
              .then((value) => {
                    print("User Added"),
                    Navigator.pop(context),
                  })
              .catchError(
                (error) => print("Failed to add user: $error"),
              );
        }
      }
    }

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Text(
                "Welcome Back",
                style: headingStyle,
              ),
              Text(
                'Sign in with your email and password \nor continue with social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              SignForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: 'assets/icons/google-icon.svg',
                    press: () async {
                      await signInWithGoogle();
                      // Navigator.pop(context);
                    },
                  ),
                  SocialCard(
                    icon: 'assets/icons/facebook.svg',
                    press: () {},
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              NoAccount(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              ManageStore(),
            ],
          ),
        ),
      ),
    );
  }
}
