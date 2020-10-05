import 'dart:async';

import 'package:Que/components/default_button.dart';
import 'package:Que/components/form_error.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();
  String email;
  String password;
  // ignore: non_constant_identifier_names
  String conf_password;
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

  final List<String> errors = [];
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
            buildConfPasswordField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
              text: 'Sign Up',
              press: () async {
                await signUp(
                  _emailController.text,
                  _passwordController.text,
                );
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
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

  TextFormField buildConfPasswordField() {
    return TextFormField(
      controller: _confpasswordController,
      obscureText: true,
      onSaved: (newValue) => conf_password = newValue,
      validator: (newValue) {
        if (_passwordController.text != newValue) {
          addError(error: kconfpassMatchError);
          Timer(Duration(seconds: 5), () {
            removeError(error: kconfpassMatchError);
          });
        } else if (newValue.isEmpty) {
          addError(error: kconfpass);
          Timer(Duration(seconds: 5), () {
            removeError(error: kconfpass);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Confirm Password',
        hintText: 'Re-enter you Password',
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

  signUp(String email, String password) async {
    await Firebase.initializeApp();
    FirebaseAuth _auth = FirebaseAuth.instance;
    // User user = FirebaseAuth.instance.currentUser;

    try {
      if (password == conf_password) {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("User sign up successful");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        addError(error: kaccountExistError);
        Timer(Duration(seconds: 5), () {
          removeError(error: kaccountExistError);
        });
      }
    } catch (e) {
      print(e.toString());
      addError(error: e.message);
      Timer(Duration(seconds: 5), () {
        removeError(error: e.message);
      });
    }
  }
}
