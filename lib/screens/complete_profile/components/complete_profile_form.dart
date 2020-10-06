import 'dart:async';

import 'package:Que/components/default_button.dart';
import 'package:Que/components/form_error.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:Que/screens/login_success/login_success_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();

  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;

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
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: 'Continue',
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await addUser(
                  _firstnamecontroller.text,
                  _lastnamecontroller.text,
                );
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: _lastnamecontroller,
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: _firstnamecontroller,
      onSaved: (newValue) => firstName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          Timer(Duration(seconds: 3), () {
            removeError(error: kNamelNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }
}

addUser(String firstName, String lastName) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'first_name': firstName, // John Doe
        'last_name': lastName, // Stokes and Sons
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
