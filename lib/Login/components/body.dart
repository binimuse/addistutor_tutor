// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print, deprecated_member_use, invalid_use_of_protected_member

import 'dart:convert';

import 'package:addistutor_tutor/Profile/editprofile.dart';
import 'package:addistutor_tutor/Profile/getmyaccount.dart';
import 'package:addistutor_tutor/Signup/components/otp.dart';
import 'package:addistutor_tutor/Signup/signup_screen.dart';
import 'package:addistutor_tutor/components/already_have_an_account_acheck.dart';

import 'package:addistutor_tutor/components/text_field_container.dart';
import 'package:addistutor_tutor/controller/avlablityconroller.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/getlevelcontroller.dart';
import 'package:addistutor_tutor/controller/getlocationcontroller.dart';
import 'package:addistutor_tutor/controller/getqualifaicationcontroller.dart';
import 'package:addistutor_tutor/controller/getsubcontroller.dart';
import 'package:addistutor_tutor/controller/signupcontroller.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';
import 'package:addistutor_tutor/main/main.dart';
import 'package:addistutor_tutor/remote_services/api.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../../constants.dart';
import 'background.dart';
import 'forgotpassword.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Body> {
  bool isLoading = false;
  GetLocationController getLocationController =
      Get.put(GetLocationController());
  final SignupController signupController = Get.put(SignupController());
  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final Getqulificationcontroller getqulificationcontroller =
      Get.put(Getqulificationcontroller());
  final Avalablitycontrollerclass avalablitycontrollerclass =
      Get.put(Avalablitycontrollerclass());
  final GetLevelContoller getLevelContoller = Get.put(GetLevelContoller());
  final GetSubect getSubect = Get.put(GetSubect());
  final WalletContoller walletContoller = Get.put(WalletContoller());
  final GetmyAccount getmyAccount = Get.put(GetmyAccount());
  @override
  void initState() {
    super.initState();

    // _fetchUser();
    _getlocation();
    _getlevel();
    _getsub();
    _getsub2();
    _getqulification();
    _getmyaccount();
    _fetchUser();
    emailcon = TextEditingController();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();
  }

  var ids;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        setState(() {
          ids = body["teacher_id"];

          walletContoller.getbalance(ids);
        });

        print("yes Id");
      } else {
        print("no Id");
      }
    } else {
      print("no Token");
    }
  }

  _getlocation() async {
    getLocationController.fetchLocation();

    // location = getLocationController.listlocation.value;
    // if (location != null && location.isNotEmpty) {
    //   setState(() {
    //     getLocationController.getLocation = location[0];
    //     getLocationController.subcity = location[0];
    //     getLocationController.g_subcity = location[0];
    //     getLocationController.e_subcity = location[0];
    //   });
    // }
  }

  List<GetLevel> level = [];
  _getlevel() async {
    getLevelContoller.fetchLocation();
  }

  List<Subjects> sub = [];
  List<Subjects2> sub2 = [];
  _getsub() async {
    getSubect.fetchLocation(editprofileController.lid);
  }

  _getsub2() async {
    getSubect.fetchLocation2();

    sub2 = getSubect.listlocation2.value;
    if (sub2.isNotEmpty) {
      setState(() {
        getSubect.subject2 = sub2[0];
      });
    }
  }

  List<GetQulification> qualification = [];
  _getqulification() async {
    getqulificationcontroller.fetchLocation();
  }

  bool showPassword1 = true;
  bool isPasswordTextField1 = true;
  SharedPreferences? localStorage;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailcon;

  var body;
  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Log in",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 23),
              ),
              SizedBox(height: size.height * 0.03),
              Image(
                image: const AssetImage(
                  'assets/images/new.png',
                ),
                height: size.height * 0.20,
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: TextFormField(
                  controller: emailcon,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Email or phone(251***)",
                    icon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (emailval) {
                    if (emailval!.isEmpty) {
                      return "Please put your email";
                    }
                    email = emailval.toString();
                    return null;
                  },
                  // validator: (value) {
                  //   return signupController.validatephone(value!);
                  // },
                ),
              ),

              TextFieldContainer(
                child: TextFormField(
                  obscureText: isPasswordTextField1 ? showPassword1 : false,
                  cursorColor: kPrimaryColor,
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
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {},
                  validator: (passwordval) {
                    if (passwordval!.isEmpty) {
                      return "Please put your Password";
                    }
                    password = passwordval.toString();
                    return null;
                  },
                ),
              ),
              // TextFieldContainer(
              //   child: TextFormField(
              //     obscureText: true,
              //     cursorColor: kPrimaryColor,
              //     decoration: InputDecoration(
              //       hintText: "Password",
              //       icon: Icon(
              //         Icons.lock,
              //         color: kPrimaryColor,
              //       ),
              //       suffixIcon: Icon(
              //         Icons.visibility,
              //         color: kPrimaryColor,
              //       ),
              //       border: InputBorder.none,
              //     ),
              //     validator: (passwordval) {
              //       if (passwordval!.isEmpty) {
              //         return "Please put your Password";
              //       }
              //       password = passwordval.toString();
              //       return null;
              //     },
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 75,
                  vertical: 20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // ignore: deprecated_member_use
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: isLoading == false
                        ? const Text(
                            'Log in',
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
              ),
              SizedBox(height: size.height * 0.03),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return const ForgotPassword();
                      },
                    ),
                  );
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    )),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
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
      ),
    );
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });
    var data = {'email': email, 'password': password};
    var res = await Network().authData(data, "login-teacher");
    body = json.decode(res.body);
    // ignore: avoid_print

    print("jejasda ${body.toString()}");
    if (res.statusCode == 200) {
      // commit();
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"]);

      localStorage.setString('user', json.encode(body['user']));

      var token = localStorage.getString('user');
      var bodys = json.decode(token!);

      if (bodys["email_verified_at"] == null) {
        _showDialog(context, 'Please verify your email or otp',
            "Go to your email or sms to confirm", () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => OTPPage(),
            ),
          );
        });
      } else {
        if (bodys["teacher_id"] == null) {
          _showDialog(context, 'To continue, please complete your profile.', "",
              () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => EditPage(),
              ),
            );
          });
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Main(),
              ),
            ),
            (route) => false,
          );
        }

        isLoading = false;
      }
    } else if (res.statusCode == 401) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('info'),
          content: Text(body["message"]),
          actions: <Widget>[
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
          title: Text(body.toString()),
          content: Text(body["message"]),
          actions: <Widget>[
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

  void _showDialog(
      BuildContext context, String title, String message, Function action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.of(context).pop(true);
              setState(() {
                isLoading = false;
              });
              action();
            },
            child: Container(
                width: 20,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
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
              'incorrect Email or Password',
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
    }
  }
}
