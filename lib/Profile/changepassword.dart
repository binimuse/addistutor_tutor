import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/constants.dart';
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

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ChangePassword> {
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
              borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
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
            "Change Password",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        body: editprofileController.obx(
            (editForm) => Form(
                  key: editprofileController.changePass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, top: 25, right: 16),
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
                                  "Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: isPasswordTextField
                                      ? showPassword
                                      : false,
                                  decoration: InputDecoration(
                                    suffixIcon: isPasswordTextField
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: kPrimaryColor,
                                            ),
                                          )
                                        : null,
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateNamep(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "new Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.newpassControl,
                                  obscureText: isPasswordTextField1
                                      ? showPassword1
                                      : false,
                                  decoration: InputDecoration(
                                    suffixIcon: isPasswordTextField1
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPassword1 = !showPassword1;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: kPrimaryColor,
                                            ),
                                          )
                                        : null,
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateNamep(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Confirm new Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.confirmpassControl,
                                  obscureText: isPasswordTextField2
                                      ? showPassword2
                                      : false,
                                  decoration: InputDecoration(
                                    suffixIcon: isPasswordTextField2
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPassword2 = !showPassword2;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: kPrimaryColor,
                                            ),
                                          )
                                        : null,
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateNamep(value!);
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
                                    editprofileController.changepass(context);

                                    //   editprofileController.passControl.clear();
                                    //    editprofileController.newpassControl    .clear();  editprofileController.confirmpassContro  .clear();

                                    // ignore: avoid_print

                                    // ignore: unrelated_type_equality_checks
                                    // editprofileController.isLoading == true
                                    //     ? const Center(
                                    //         child: CircularProgressIndicator())
                                    //     : _showMessage();
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  label: const Text(
                                    'Update Password',
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
            onLoading: Center(child: loadData()),
            onEmpty: const Text("Can't fetch data"),
            onError: (error) => Center(child: Text(error.toString()))));
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
