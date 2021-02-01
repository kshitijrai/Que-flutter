import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:Que/screens/Store/store_signup/components/sign_up_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Register Account",
              style: headingStyle,
            ),
            Text(
              'Complete your details',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            StoreSignUpForm(),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Text(
              "By continuing you confirm that you agree \nwith our Terms and Conditions",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
