import 'package:Que/components/default_button.dart';
import 'package:Que/components/form_error.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class StoreDetailsForm extends StatefulWidget {
  @override
  _StoreDetailsFormState createState() => _StoreDetailsFormState();
}

class _StoreDetailsFormState extends State<StoreDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _storecontroller = TextEditingController();
  final TextEditingController _locationcontroller = TextEditingController();
  final TextEditingController _waittimecontroller = TextEditingController();

  final List<String> errors = [];
  String storeName;
  String location;
  int currentline;
  int waitTime;
  List<String> inline = [];
  bool isJoined;

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
    addStore(String mystorename) {
      User user = FirebaseAuth.instance.currentUser;
      CollectionReference storeRef =
          FirebaseFirestore.instance.collection('stores');
      DocumentReference stores = storeRef.doc(mystorename);

      if (user != null) {
        return stores
            .set({
              'email': user.email,
              'storeid': user.uid,
              'lineCount': 0,
              'lines': {},
              'storeName': mystorename,
              'location': location,
              'waitTime': waitTime,
            })
            .then((value) => {
                  print("User Name Added"),
                  Navigator.pop(context),
                })
            .catchError(
              (error) => print("Failed to add user: $error"),
            );
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildStoreNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLocationFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildWaitTimeFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: 'Finish',
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await addStore(
                  _storecontroller.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildLocationFormField() {
    return TextFormField(
      controller: _locationcontroller,
      onSaved: (newValue) => location = newValue,
      decoration: InputDecoration(
        labelText: "Location",
        hintText: "Enter your store Location",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on),
      ),
    );
  }

  TextFormField buildStoreNameFormField() {
    return TextFormField(
      controller: _storecontroller,
      onSaved: (newValue) => storeName = newValue,
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
        labelText: "Store Name",
        hintText: "Enter your store name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.store_outlined),
      ),
    );
  }

  TextFormField buildWaitTimeFormField() {
    return TextFormField(
      controller: _waittimecontroller,
      onSaved: (newValue) => waitTime = int.parse(newValue),
      decoration: InputDecoration(
        labelText: "WaitTime",
        hintText: "Store's avg wait time",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.timer),
      ),
    );
  }
}
