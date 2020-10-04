import 'package:Que/design/size_config.dart';
import 'package:Que/design/uiconstants.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(
          flex: 2,
        ),
        Text(
          "Que",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(36),
              color: kPrimaryColor,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(300),
        )
      ],
    );
  }
}
