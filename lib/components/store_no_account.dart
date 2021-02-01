import 'package:Que/refer/size_config.dart';
import 'package:Que/screens/Store/store_signup/sign_up_screen.dart';
import 'package:flutter/material.dart';

class StoreNoAccount extends StatelessWidget {
  const StoreNoAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Store not Registered? ',
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.popAndPushNamed(context, StoreSignUpScreen.routeName),
          child: Text(
            'Register Here',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Colors.blue,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
