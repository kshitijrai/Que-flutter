import 'package:Que/design/size_config.dart';
import 'package:Que/screens/splash/components/body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // Call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
