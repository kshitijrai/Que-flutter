import 'package:Que/components/default_button.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/refer/uiconstants.dart';
import 'package:Que/screens/home/home_screen.dart';
import 'package:Que/screens/sign_in/sign_in_screen.dart';
import 'package:Que/screens/splash/components/splash_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      'text': "Project Que welcomes you!\nLet's get started.",
      'image': 'assets/images/splash_0.png'
    },
    {
      'text': "On a click, Select your favourite store",
      'image': 'assets/images/splash_1.png'
    },
    {
      'text':
          "Select your preffered slot to visit the store \n or join the current queue.",
      'image': 'assets/images/splash_2.png'
    },
    {
      'text': "Stay away from long queues and stay safe!",
      'image': 'assets/images/splash_3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(30)),
            Text(
              "Que",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(36),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]['image'],
                    text: splashData[index]['text']),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User user) {
                            if (user == null) {
                              print('User is currently signed out!');
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            } else {
                              print('User is signed in!');
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            }
                          });
                        },
                      ),
                      RaisedButton(onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        await GoogleSignIn().signOut();
                      }),
                      Spacer(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
