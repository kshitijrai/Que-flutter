import 'dart:async';

import 'package:Que/components/default_button.dart';
import 'package:Que/components/form_error.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:Que/screens/forgot_password/forgot_pass_screen.dart';
import 'package:Que/screens/login_success/login_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email;
  String password;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildEmailField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
              text: 'Sign In',
              press: () async {
                if (_formKey.currentState.validate()) {
                  await signIn();
                  _formKey.currentState.save();
                  Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value.isEmpty) {
          setState(() {
            addError(error: kPassNullError);
            Timer(Duration(seconds: 5), () {
              removeError(error: kPassNullError);
            });
          });
        } else if (value.length < 8) {
          setState(() {
            addError(error: kShortPassError);
            Timer(Duration(seconds: 5), () {
              removeError(error: kShortPassError);
            });
          });
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Password',
        hintText: 'Enter you Password',
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        if (value.isEmpty) {
          setState(() {
            addError(error: kEmailNullError);
            Timer(Duration(seconds: 3), () {
              removeError(error: kEmailNullError);
            });
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          addError(error: kInvalidEmailError);
          Timer(Duration(seconds: 3), () {
            removeError(error: kInvalidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Email',
        hintText: 'Enter you email',
        suffixIcon: Icon(Icons.mail_outline),
      ),
    );
  }

  signIn() async {
    await Firebase.initializeApp();
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      print("Signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(userexist);

        setState(() {
          addError(error: userexist);
        });
      } else if (e.code == 'wrong-password') {
        print(wrongpass);
        setState(() {
          addError(error: wrongpass);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
