import 'package:Que/components/default_button.dart';
import 'package:Que/components/form_error.dart';
import 'package:Que/design/size_config.dart';
import 'package:Que/design/uiconstants.dart';
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
                Text(
                  'Forgot Password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
              text: 'Sign In',
              press: () async {
                await signIn(_emailController.text, _passwordController.text);
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
      onSaved: (String newValue) => password = newValue,
      onChanged: (String value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 ||
            value.length == 0 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (String value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
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
      onSaved: (String newValue) => email = newValue,
      onChanged: (String value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (String value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
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

  signIn(String email, String password) async {
    await Firebase.initializeApp();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(userexist);
        showError(userexist);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SignIn - Error'),
            content: Text(
              errormessage,
              style: TextStyle(color: Colors.red),
            ),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
