import 'package:Que/route.dart';
import 'package:Que/screens/splash/splash_screen.dart';
import 'package:Que/screens/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Que',
      theme: theme(),
      // home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
