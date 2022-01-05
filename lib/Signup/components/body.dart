import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/Signup/components/social_icon.dart';
import 'package:addistutor_tutor/components/already_have_an_account_acheck.dart';
import 'package:addistutor_tutor/components/rounded_button.dart';
import 'package:addistutor_tutor/components/rounded_password_field.dart';
import 'package:addistutor_tutor/components/text_field_container.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'background.dart';
import 'or_divider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              const Text(
                "SIGNUP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 23),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.15,
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const TextFieldContainer(
                      child: TextField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: kPrimaryColor,
                          ),
                          hintText: "Your email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // TextFieldContainer(
                    //   child: TextField(
                    //     cursorColor: kPrimaryColor,
                    //     decoration: InputDecoration(
                    //       icon: Icon(
                    //         Icons.phone,
                    //         color: kPrimaryColor,
                    //       ),
                    //       hintText: "Your Phone",
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    const TextFieldContainer(
                      child: TextField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_add,
                            color: kPrimaryColor,
                          ),
                          hintText: "Username",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    RoundedPasswordField(
                      onChanged: (value) {},
                    ),

                    RoundedButton(
                      text: "SIGNUP",
                      press: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
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
