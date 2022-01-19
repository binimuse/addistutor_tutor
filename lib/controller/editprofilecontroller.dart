// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter

import 'dart:convert';

import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: prefer_typing_uninitialized_variables
  var inforesponse;
  var isLoading = false.obs;
  // ignore: non_constant_identifier_names

  late TextEditingController firstname;
  late TextEditingController lastname;

  late TextEditingController phone;
  late TextEditingController email;

  var date;
  var id;
  //GetLocation? selectedModel;

  late TextEditingController About;
  // ignore: non_constant_identifier_names

  var isFetched = false.obs;
  var ifupdatd = false.obs;
  @override
  void onInit() {
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    About = TextEditingController();

    super.onInit();
  }

  var fetched;

  Future<void> fetchPf(var id) async {
    if (id == "noid") {
      change(fetched, status: RxStatus.success());
      isFetched.value = true;
    } else {
      try {
        //  openAndCloseLoadingDialog();
        fetched = await RemoteServices.fetchpf(id);
        //   print(fetched);
        if (fetched != "") {
          isFetched.value = true;
          id = fetched.id;

          firstname.text = fetched.first_name;
          lastname.text = fetched.last_name;
          phone.text = fetched.phone_no;
          email.text = fetched.email;
          date = fetched.birth_date;
          About.text = fetched.about;

          await Future.delayed(const Duration(seconds: 1));
          // Dismiss CircularProgressIndicator
          //   Navigator.of(Get.context!).pop();
        }
        change(fetched, status: RxStatus.success());
      } on Exception {
        change(null, status: RxStatus.error("Something went wrong"));

        // ignore: todo
        // TODO
      }
    }
  }

  void editProf(id, BuildContext context) async {
    try {
      final isValid = EditProf.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        EditProf.currentState!.save();
        await seteditInfo(id, context);
      }
    } finally {
      // ignore: todo
      // TODO
    }
  }

  var image;

  Future<void> seteditInfo(ids, BuildContext context) async {
    print(ids);
    openAndCloseLoadingDialog(context);
    var uploaded = await RemoteServices.uploadImage(image, ids.toString());

    if (uploaded) {
      var data = {
        "first_name": firstname.text,
        "last_name": lastname.text,
        "phone_no": phone.text,
        "birth_date": date,
        "email": email.text,
        "about": About.text,
      };
      inforesponse = await RemoteServices.editPersonalInfo(data);
      if (inforesponse.toString() == "200") {
        closeDialog(true, '', context);
        isLoading(false);

        ifupdatd(true);
      } else {
        closeDialog(false, inforesponse, context);

        ifupdatd(false);
      }
    } else {
      print("yes am here");
      var data = {
        "first_name": firstname.text,
        "last_name": lastname.text,
        "phone_no": phone.text,
        "birth_date": date,
        "email": email.text,
        "about": About.text,

//delete
        "middle_name": "test",
        "gender": "male",
        "grade": "5",
        "study_purpose": "Regular support",
        "experience": 21,
        "teaching_since": 2021,
        "location_id": 1,
        "subject_id": 1,
        "qualification_id": 1,
      };
      inforesponse = await RemoteServices.editPersonalInfo(data);
      if (inforesponse.toString() == "200") {
        closeDialog(true, '', context);
        isLoading(false);
      } else {
        closeDialog(false, inforesponse, context);
      }
    }
  }

  // openAndCloseLoadingDialog() {

  // }

  closeDialog(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'profile Not Edited',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                isLoading(false);
                Navigator.of(context).pop(true);
              },
              child: new Text('ok'),
            ),
          ],
        ),
      );
    } else {
      // ignore: deprecated_member_use

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'profile Edited',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          content: const Text(
            'if its your first time updating your profile you will me redirected to login',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                isLoading(false);
                Navigator.of(context).pop(true);

                SharedPreferences localStorage =
                    await SharedPreferences.getInstance();
                localStorage.setBool('isupdated', true);

                var token = localStorage.getString('user');

                if (token != null) {
                  body = json.decode(token);

                  if (body["student_id"] != null) {
                    Navigator.pop(context);
                    isLoading(false);
                    //    openAndCloseLoadingDialog(context);
                    print("yess");
                  } else {
                    isLoading(false);

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return LoginScreen();
                        },
                      ),
                    );
                  }
                }
              },
              child: new Text('ok'),
            ),
          ],
        ),
      );
      editstudentid(context);
    }
  }

  openSnackBaredit(BuildContext context) async {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("profile Edited"),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
      backgroundColor: kPrimaryColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      elevation: 30,
    ));
  }

  var body;
  Future<void> editstudentid(BuildContext context) async {}

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please Provide a name";
    }
    return null;
  }

  void openAndCloseLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: kPrimaryColor,
              strokeWidth: 8,
            ),
          ),
        ),
      ),
    );
  }
}
