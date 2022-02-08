import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';

import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ForgotPassword> {
  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  //List<Animal> _selectedAnimals = [];

  // ignore: prefer_typing_uninitialized_variables
  var body;

  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    // ignore: avoid_print
    print(token);
    if (token != null) {
      // ignore: avoid_print
      print(token.toString());
      body = json.decode(token);
      // ignore: avoid_print
      print(body["id"]);
      //  editprofileController.fetchProfile(body["id"]);
    }
  }

  bool showPassword1 = true;
  bool isPasswordTextField1 = true;

  bool showPassword = true;
  bool isPasswordTextField = true;

  bool showPassword2 = true;
  bool isPasswordTextField2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Material(
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
            child: Icon(
              Icons.arrow_back_ios,
              color: DesignCourseAppTheme.nearlyBlack,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Form(
        key: editprofileController.forgot,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: editprofileController.forgotpass,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSaved: (value) {
                          editprofileController.forgo = value.toString();
                        },
                        validator: (value) {
                          return editprofileController.validateEmail(value!);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton.icon(
                        onPressed: () {
                          editprofileController.forgotpassword(context);
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        label: const Text(
                          'Ok',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.update,
                          color: Colors.white,
                        ),
                        textColor: kPrimaryColor,
                        splashColor: Colors.white,
                        color: kPrimaryColor,
                      ),
                      // ignore: deprecated_member_use

                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  ImagePicker picker = ImagePicker();

  void _showMessage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('info'),
              content:
                  Text(json.decode(editprofileController.edited)["message"]),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('ok'),
                ),
              ],
            ));
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }
}
