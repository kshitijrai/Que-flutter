import 'package:Que/refer/size_config.dart';
import 'package:Que/screens/Store/store_signin/store_signin.dart';
import 'package:flutter/material.dart';

class ManageStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () =>
              Navigator.popAndPushNamed(context, StoreSignin.routeName),
          child: Text(
            'Manage Store',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Colors.grey,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
