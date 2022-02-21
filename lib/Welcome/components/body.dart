import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/Signup/signup_screen.dart';
import 'package:addistutor_tutor/components/rounded_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Welcome to NextGen ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 23),
            ),
            const Text(
              "Tutor Applicaion",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                  fontSize: 20),
            ),
            SizedBox(height: size.height * 0.05),
            Image(
              image: AssetImage(
                'assets/images/login.jpg',
              ),
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
