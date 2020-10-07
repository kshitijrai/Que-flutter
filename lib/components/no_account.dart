import 'package:Que/refer/size_config.dart';
import 'package:Que/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.popAndPushNamed(context, SignUpScreen.routeName),
          child: Text(
            'Sign Up',
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
