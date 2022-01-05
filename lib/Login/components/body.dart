import 'package:addistutor_tutor/Signup/signup_screen.dart';
import 'package:addistutor_tutor/components/already_have_an_account_acheck.dart';
import 'package:addistutor_tutor/components/rounded_button.dart';
import 'package:addistutor_tutor/components/rounded_input_field.dart';
import 'package:addistutor_tutor/components/rounded_password_field.dart';
import 'package:addistutor_tutor/main/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'background.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 23),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return Main();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return SignUpScreen();
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
