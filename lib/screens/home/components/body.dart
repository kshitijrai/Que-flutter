import 'package:Que/screens/dashboard/dashboard.dart';
import 'package:Que/screens/notifications/notification.dart';
import 'package:Que/screens/user_profile/profile.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex;
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(
      initialPage: currentIndex,
    );

    void changePage(int index) {
      setState(() {
        currentIndex = index;
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.easeOutQuint);
      });
    }

    final pageView = PageView(
      controller: pageController,
      physics: BouncingScrollPhysics(),
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      children: <Widget>[
        Dashboard(),
        NotificationPage(),
        ProfileScreen(),
      ],
    );
    return Scaffold(
      body: pageView,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
          backgroundColor: Colors.white,
          hasNotch: true,
          opacity: .2,
          currentIndex: currentIndex,
          onTap: changePage,
          elevation: 8,
          items: [
            new BubbleBottomBarItem(
              icon: const Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text('Dashboard'),
              backgroundColor: Colors.red,
            ),
            new BubbleBottomBarItem(
                icon: const Icon(Icons.notifications_active,
                    color: Colors.deepOrange),
                title: Text('Notification'),
                backgroundColor: Colors.deepOrange),
            new BubbleBottomBarItem(
                icon: const Icon(Icons.account_circle, color: Colors.indigo),
                title: Text('Profile'),
                backgroundColor: Colors.indigo)
          ]),
    );
  }
}
