// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/Profile/termsodservice.dart';
import 'package:addistutor_tutor/Signup/components/otp.dart';
import 'package:addistutor_tutor/Signup/components/social_icon.dart';
import 'package:addistutor_tutor/components/already_have_an_account_acheck.dart';

import 'package:addistutor_tutor/components/text_field_container.dart';
import 'package:addistutor_tutor/controller/signupcontroller.dart';
import 'package:addistutor_tutor/remote_services/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import 'background.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Body> {
  bool showPassword1 = true;
  bool isPasswordTextField1 = true;
  final _multiSelectKey = GlobalKey<FormState>();
  SignupController signupController = Get.put(SignupController());

  bool isLoading = false;
  var inforesponse;
  bool isChecked = false;
  bool _isLoggedIn = false;

  bool ispassChecked = false;
  var confirmpass;
  late GoogleSignInAccount _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 23),
              ),
              SizedBox(height: size.height * 0.03),
              Image(
                image: AssetImage(
                  'assets/images/new.png',
                ),
                height: size.height * 0.15,
              ),
              Form(
                key: _multiSelectKey,
                child: Column(
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        controller: signupController.fullname,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person_add,
                            color: kPrimaryColor,
                          ),
                          hintText: "Full Name",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return signupController.validateName(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        controller: signupController.email,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: kPrimaryColor,
                          ),
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return signupController.validateEmail(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        controller: signupController.phone,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          hintText: "Phone 2519",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                        ],
                        validator: (value) {
                          return signupController.validatephone(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        obscureText:
                            isPasswordTextField1 ? showPassword1 : false,
                        cursorColor: kPrimaryColor,
                        controller: signupController.password,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: const Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: isPasswordTextField1
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword1 = !showPassword1;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: kPrimaryColor,
                                  ),
                                )
                              : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {},
                        validator: (value) {
                          return signupController.validateNamep(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        obscureText:
                            isPasswordTextField1 ? showPassword1 : false,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Confirm password",
                          icon: const Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: isPasswordTextField1
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword1 = !showPassword1;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: kPrimaryColor,
                                  ),
                                )
                              : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (values) {
                          setState(() {
                            confirmpass = values;
                          });
                        },
                        onSaved: (value) {},
                        validator: (value) {
                          return signupController.validateNamep(value!);
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: kPrimaryColor,
                        checkColor: kPrimaryLightColor,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: 'I agree with the terms of service',
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return const ProductDescriptionPage();
                                          },
                                        ),
                                      );
                                    },
                                ),
                              ]),
                        ),
                      ),
                    ]),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        color: kPrimaryColor,
                        onPressed: () {
                          if (signupController.password.text == confirmpass) {
                            setState(() {
                              ispassChecked = true;
                            });
                          } else {
                            setState(() {
                              ispassChecked = false;
                            });
                          }
                          if (_multiSelectKey.currentState!.validate()) {
                            if (ispassChecked == true) {
                              isChecked
                                  ? register()
                                  : showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            "please check terms of service"),
                                        actions: <Widget>[
                                          // ignore: deprecated_member_use
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                            child: const Text('ok'),
                                          ),
                                        ],
                                      ),
                                    );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text("Password don't match"),
                                  actions: <Widget>[
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      child: const Text('ok'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: isLoading == false
                              ? const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    )
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
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const OrDivider(),
              const Text(
                "Register with Google?",
                style: TextStyle(color: kPrimaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/images/google.png",
                    press: () {
                      _googleSignIn.signIn().then((userData) {
                        setState(() {
                          _isLoggedIn = true;
                          _userObj = userData!;
                        });

                        signupController.email.text = _userObj.email;
                        signupController.fullname.text = _userObj.displayName!;

                        if (_isLoggedIn) {
                          registerbygoogle();
                        }

                        // register();
                      }).catchError((e) {
                        print(e);
                        setState(() {
                          _googleSignIn.signOut().then((value) {
                            setState(() {
                              _isLoggedIn = false;
                            });
                          }).catchError((e) {});
                        });

               
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  registerbygoogle() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "email": signupController.email.text,
      "full_name": signupController.fullname.text,
    };

    var res = await Network().authData(data, 'register-teacher');
    var body = json.decode(res.body);

    //print(body.toString());
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"]);

      localStorage.setString('user', json.encode(body['user']));

      closeDialog(true, '');
      isLoading = false;
    } else if (res.statusCode == 422) {
      setState(() {
        _googleSignIn.signOut().then((value) {
          setState(() {
            _isLoggedIn = false;
          });
        }).catchError((e) {});
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(body["errors"].toString()),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  isLoading = false;
                });
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    } else {
      closeDialog(false, res);
    }

    setState(() {
      isLoading = false;
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "email": signupController.email.text,
      "full_name": signupController.fullname.text,
      "phone": signupController.phone.text,
      "password": signupController.password.text,
    };

    var res = await Network().authData(data, 'register-teacher');
    var body = json.decode(res.body);

    //print(body.toString());
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"]);

      localStorage.setString('user', json.encode(body['user']));

      closeDialog(true, '');
      isLoading = false;
    } else if (res.statusCode == 422) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(body["errors"].toString()),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  isLoading = false;
                });
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    } else {
      closeDialog(false, res);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> closeDialog(bool stat, var data) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    // Navigator.of(Get.context!).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              'Error',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              color: kPrimaryColor,
            ),
          ]),
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              "Running tO a problem please try again",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
          ]),
          actions: <Widget>[
            // ignore: deprecated_member_use
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: InkWell(
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.of(context).pop(true);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              'Registered successfully',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              color: kPrimaryColor,
            ),
          ]),
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please check your email inbox or your sms  to verify your email address  or phone number  before you log in.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 15),
          ]),
          actions: <Widget>[
            // ignore: deprecated_member_use
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: InkWell(
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.of(context).pop(true);
                  setState(() {
                    isLoading = false;
                  });
                  // Navigator.push<dynamic>(
                  //   context,
                  //   MaterialPageRoute<dynamic>(
                  //     builder: (BuildContext context) => const LoginScreen(),
                  //   ),
                  // );
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => OTPPage(),
                    ),
                  );
                },
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    setState(() {
                      isLoading = false;
                    });
                    // Navigator.push<dynamic>(
                    //   context,
                    //   MaterialPageRoute<dynamic>(
                    //     builder: (BuildContext context) => const LoginScreen(),
                    //   ),
                    // );

                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => OTPPage(),
                      ),
                    );
                  },
                  child: Container(
                      width: 25,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
