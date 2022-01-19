import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController with StateMixin {
  GlobalKey<FormState> Form = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController password;

  @override
  void onInit() {
    fullname = TextEditingController();

    email = TextEditingController();
    fullname = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  var inforesponse;

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

  String? validatePass(String value) {
    if (!validateStructure(value)) {
      return "please Provide a valid password";
    }
    return null;
  }

  String? validatephone(String value) {
    if (value.isEmpty) {
      return "please Provide phone number";
    }
    return null;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
