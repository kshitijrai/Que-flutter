import 'package:Que/components/store.dart';
import 'package:Que/refer/size_config.dart';
import 'package:Que/screens/dashboard/components/HomeHeader.dart';
import 'package:Que/screens/dashboard/components/categories.dart';
import 'package:Que/screens/dashboard/components/store_card.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Categories(),
            SizedBox(height: getProportionateScreenHeight(20)),
            StoreCard(),
          ],
        ),
      ),
    );
  }
}
