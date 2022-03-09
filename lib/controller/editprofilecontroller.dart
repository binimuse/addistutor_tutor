// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter, deprecated_member_use

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

  final GlobalKey<FormState> changePass = GlobalKey<FormState>();
  final GlobalKey<FormState> forgot = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var inforesponse;
  var isLoading = false.obs;
  // ignore: non_constant_identifier_names
  late var macthgender = "".obs;
  late var since = "".obs;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController middlename;

//guarantor
  late TextEditingController g_firstname;
  late TextEditingController g_lastname;

  late TextEditingController g_woreda;
  late TextEditingController g_phone;
  late TextEditingController g_office_phone;

  late TextEditingController phone;
  late TextEditingController officephone;
  late TextEditingController rephone;

  late TextEditingController woreda;
  late TextEditingController email;

  // EMPLOYMENT
  late TextEditingController e_firstname;
  late TextEditingController e_postion;

  late TextEditingController e_woreda;
  var e_subject;

  //update pass
  late TextEditingController passControl;
  late TextEditingController newpassControl;
  late TextEditingController confirmpassControl;
  late TextEditingController forgotpass;
  var pass = '';
  var forgo = '';
  var date;
  var locationid;
  var subcityid;
  var g_subcityid;
  var e_subcityid;
  var lid = "";
  var level;
  var qualifications;
  var fieldofstudy;

  //GetLocation? selectedModel;

  late TextEditingController About;
  // ignore: non_constant_identifier_names

  var isFetched = false.obs;
  var isActive = false.obs;
  var ifupdatd = false.obs;

  @override
  void onInit() {
    //editprofile
    firstname = TextEditingController();
    lastname = TextEditingController();
    middlename = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    officephone = TextEditingController();
    rephone = TextEditingController();
    woreda = TextEditingController();

    About = TextEditingController();

    //GUARANTOR CONTACT INFORMATION
    g_firstname = TextEditingController();
    g_lastname = TextEditingController();

    g_woreda = TextEditingController();
    g_phone = TextEditingController();
    g_office_phone = TextEditingController();
//EMPLOYMENT INFORMATION
    e_firstname = TextEditingController();
    e_postion = TextEditingController();

    e_woreda = TextEditingController();

    //update pass
    passControl = TextEditingController();
    newpassControl = TextEditingController();
    confirmpassControl = TextEditingController();
    //forgot
    forgotpass = TextEditingController();
    super.onInit();
  }

  var fetched;
  var edited = "";

  void forgotpassword(BuildContext context) async {
    try {
      final isValid = forgot.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        forgot.currentState!.save();
        await forgott(context);
      }
    } finally {}
  }

  var emailadd = "";
  Future<void> forgott(context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "email": forgotpass.text,
    };
    print(data);
    emailadd = await RemoteServices.forgott(data);
    print(emailadd.toString());
    if (emailadd.toString() == "200") {
      closeDialogforgot(true, emailadd, context);
      isLoading(false);
      print("yess");
    } else {
      //inforesponse = edited;
      closeDialogforgot(false, emailadd, context);
      print("noo");
      //  print(edited.toString());
    }
  }

  closeDialogforgot(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            data.toString(),
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
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                isLoading(false);
              },
              child: const Text('ok'),
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
            'cheak your email aadress ',
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
                //    openAndCloseLoadingDialog(context);
                print("yess");
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  void changepass(BuildContext context) async {
    try {
      final isValid = changePass.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        changePass.currentState!.save();
        await updatePass(context);
      }
    } finally {
      // ignore: todo
      // TODO
    }
  }

  Future<void> updatePass(context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "old_password": passControl.text,
      "password": newpassControl.text,
      "password_confirmation": confirmpassControl.text,
    };
    print(data);
    edited = await RemoteServices.updatepass(data);
    //print(edited.toString());
    if (edited.toString() == "200") {
      closeDialogpassword(true, edited, context);
      isLoading(false);
      print("yess");
    } else {
      //inforesponse = edited;
      closeDialogpassword(false, edited, context);
      print("noo");
      //  print(edited.toString());
    }
  }

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
          middlename.text = fetched.middle_name;
          phone.text = fetched.phone_no;
          macthgender.value = fetched.gender;
          since.value = fetched.teaching_since;
          email.text = fetched.email;
          date = fetched.birth_date;
          officephone.text = fetched.phone_no_office;
          rephone.text = fetched.phone_no_residence;
          subcityid = fetched.subcity;
          woreda.text = fetched.woreda;
          g_firstname.text = fetched.guarantor_name;
          g_woreda.text = fetched.guarantor_woreda;
          g_subcityid = fetched.guarantor_subcity;
          g_phone.text = fetched.guarantor_phone;
          g_office_phone.text = fetched.guarantor_phone_office;
          e_firstname.text = fetched.employer_name;
          e_postion.text = fetched.employer_position;
          e_subject = fetched.employment_subject;
          e_subcityid = fetched.employer_city;
          e_woreda.text = fetched.employer_woreda;

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

    print("yes am here");
    var data = {
      "first_name": firstname.text,
      "middle_name": middlename.text,
      "last_name": lastname.text,
      "gender": macthgender.value,
      "phone_no": phone.text,
      "birth_date": date,
      "teaching_since": since.value,
      "email": email.text,
      "phone_no_office": officephone.text,
      "phone_no_residence": rephone.text,
      "guarantor_name": g_firstname.text,
      "guarantor_woreda": g_woreda.text,
      "guarantor_subcity": g_subcityid,
      "guarantor_phone": g_phone.text,
      "guarantor_phone_office": g_office_phone.text,
      "guarantor_phone_residence": g_office_phone.text,
      "employer_name": e_firstname.text,
      "employer_position": e_postion.text,
      "employer_woreda": e_woreda.text,
      "employer_city": e_subcityid,
      "employment_subject": e_subject,
      "about": About.text,
      "subject_id": fieldofstudy,
      "qualification_id": qualifications,
      "address_id": locationid,
      "subcity": subcityid,
      "woreda": woreda.toString(),
    };
    inforesponse = await RemoteServices.editPersonalInfo(data);
    print(inforesponse.toString());
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);
    }
  }

  closeDialogpassword(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Password Not Updated \n ' + data.toString(),
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
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                isLoading(false);
              },
              child: const Text('ok'),
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
            'Password Edited',
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
                //    openAndCloseLoadingDialog(context);
                print("yess");
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  closeDialog(bool stat, String data, BuildContext context) async {
    Future.delayed(const Duration(seconds: 1));
    var body;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // Dismiss CircularProgressIndicator
    //Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'profile Not Edited' + data,
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

      if (token != null) {
        body = json.decode(token);

        if (body["teacher_id"] != null) {
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
                  child: const Text('ok'),
                ),
              ],
            ),
          );

          //    openAndCloseLoadingDialog(context);
          print("yess");
        } else {
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
                'if its your first time updating your profile you will be redirected to login',
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
                  child: const Text('ok'),
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

  String? validateNamep(String value) {
    if (value.isEmpty) {
      return "please Provide a Password";
    }
    return null;
  }

  String? validatePass(String value) {
    if (!validateStructure(value)) {
      return "please Provide a valid password";
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
