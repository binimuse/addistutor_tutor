// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';

import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/controller/getlocationcontroller.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Updateprofilecontoller extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> changePass = GlobalKey<FormState>();
  final GlobalKey<FormState> forgot = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var inforesponse;
  var isLoading = false.obs;
  // ignore: non_constant_identifier_names
  late var macthgender = "".obs;
  late var since = "".obs;
  GetLocationController getLocationController = Get.find();
//guarantor

  late TextEditingController phone;
  late TextEditingController officephone;
  late TextEditingController rephone;

  late TextEditingController woreda;
  late TextEditingController email;

  var subcityid;

  //GetLocation? selectedModel;

  late TextEditingController About;
  // ignore: non_constant_identifier_names

  var isFetched = false.obs;
  var isActive = false.obs;
  var ifupdatd = false.obs;

  @override
  void onInit() {
    //editprofile

    email = TextEditingController();
    phone = TextEditingController();
    officephone = TextEditingController();
    rephone = TextEditingController();
    woreda = TextEditingController();

    About = TextEditingController();

    super.onInit();
  }

  var fetched;
  var edited = "";

  var emailadd = "";

  Future<void> fetchPf(var id) async {
    if (id == "noid") {
      change(fetched, status: RxStatus.success());
      isFetched.value = true;
    } else {
      try {
        //  openAndCloseLoadingDialog();
        fetched = await RemoteServices.fetchpf(id);

        if (fetched != "") {
          isFetched.value = true;
          id = fetched.id;

          phone.text = fetched.phone_no;

          email.text = fetched.email;

          officephone.text = fetched.phone_no_office;
          rephone.text = fetched.phone_no_residence;
          subcityid = fetched.subcity;
          woreda.text = fetched.woreda;

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
    openAndCloseLoadingDialog(context);

    var uploaded = await RemoteServices.uploadImage(image, ids.toString());
    if (uploaded) {
      var data = {
        "phone_no": phone.text,
        "phone_no_office": officephone.text,
        "phone_no_residence": rephone.text,
        "subcity": getLocationController.listlocationvalue.value!.name,
        "woreda": woreda.text,
        "about": About.text,
      };
      inforesponse = await RemoteServices.UpdateProfile(data);
      if (inforesponse.toString() == "200") {
        closeDialog(true, '', context);
        isLoading(false);
        update();

        ifupdatd(true);
      } else {
        closeDialog(false, inforesponse, context);

        ifupdatd(false);
      }
    } else {
      print("am here");
      print(getLocationController.listlocationvalue.value!.name);

      var data = {
        "phone_no": phone.text,
        "phone_no_office": officephone.text,
        "phone_no_residence": rephone.text,
        "subcity": getLocationController.listlocationvalue.value!.name,
        "woreda": woreda.text,
        "about": About.text,
      };
      inforesponse = await RemoteServices.UpdateProfile(data);
      if (inforesponse.toString() == "200") {
        closeDialog(true, '', context);
        isLoading(false);
        update();
      } else {
        print(inforesponse.toString());
        closeDialog(false, inforesponse, context);
      }
    }
  }

  closeDialog(bool stat, String data, BuildContext context) async {
    Future.delayed(const Duration(seconds: 1));
    var body;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // Dismiss CircularProgressIndicator
    // Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Profile incomplete. ' + data,
            style: const TextStyle(
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

                Navigator.pop(context);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    } else {
      // ignore: deprecated_member_use

      localStorage.setBool('isupdated', true);

      var token = localStorage.getString('user');
      Navigator.pop(context);
      if (token != null) {
        body = json.decode(token);

        if (body["teacher_id"] != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Successfully saved',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
              ),
              content: const Text(
                '',
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

                    Navigator.pop(context);
                    isLoading(false);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          //    openAndCloseLoadingDialog(context);

        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Successfully saved',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
              ),
              content: const Text(
                'If this is your first time updating your profile, you will be redirected to the log in page.',
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

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }

      editstudentid(context);
    }
  }

  openSnackBaredit(BuildContext context) async {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: const Text("profile Edited"),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
      backgroundColor: kPrimaryColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
    ));
  }

  Future<void> editstudentid(BuildContext context) async {}

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid email";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide a name";
    }
    return null;
  }

  String? validateNamep(String value) {
    if (value.isEmpty) {
      return "Please provide a password";
    }
    return null;
  }

  String? validatePass(String value) {
    if (!validateStructure(value)) {
      return "Please provide a valid password";
    }
    return null;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String? validateNameaboutme(String value) {
    if (value.length < 150) {
      return "About me must be at least 150 character";
    }
    return null;
  }

  String? validateworeda(String value) {
    if (value.isEmpty) {
      return "Please provide woreda";
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
