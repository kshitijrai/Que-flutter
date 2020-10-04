import 'package:Que/components/social_card.dart';
import 'package:Que/design/size_config.dart';
import 'package:Que/screens/sign_in/components/signin_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sign in with your email and password \nor continue with social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              SignForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: 'assets/icons/google-icon.svg',
                    press: () {},
                  ),
                  SocialCard(
                    icon: 'assets/icons/facebook.svg',
                    press: () {},
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
