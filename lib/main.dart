import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.

        // '/search': (context) => const Sea(),
      },
    );
  }
}
