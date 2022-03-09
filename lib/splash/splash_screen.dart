import 'dart:convert';

import 'package:addistutor_tutor/Login/components/background.dart';
import 'package:addistutor_tutor/Progress/progress.dart';
import 'package:addistutor_tutor/main/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAuth = false;

  @override
  void initState() {
    var d = const Duration(seconds: 5);

    // delayed 3 seconds to next page
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: isAuth ? const Main() : const MyPages(),
          ),
        ),
        (route) => false,
      );
    });
    _checkIfLoggedIn();

    super.initState();
  }

  void _checkIfLoggedIn() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');

      var user = localStorage.getString('user');
      var bodys = json.decode(user!);

      if (token != null &&
          bodys["email_verified_at"] != null &&
          bodys["teacher_id"] != null) {
        setState(() {
          isAuth = true;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/lg3.png',
                height: 170,
                width: 360,
              ),
            ),
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Text(
                        "One-on-One \n Tutorial Service",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                          height: 0.9,
                          color: kPrimaryLightColor,
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Increase your income by working flexibly!",
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.2,
                height: 0.9,
                color: Color(0xFF4A6572),
              ),
            )
          ]),
    ));
  }
}
