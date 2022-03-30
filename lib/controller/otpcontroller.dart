// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_null_comparison, duplicate_ignore, deprecated_member_use, empty_catches

import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class OtpController extends GetxController with StateMixin {
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController otp1;
  late TextEditingController otp2;
  late TextEditingController otp3;
  late TextEditingController otp4;
  late TextEditingController slipid;

  var inforesponse;
  var isLoading = false.obs;
  var isFetched = false.obs;
  @override
  void onInit() {
    otp1 = TextEditingController();
    otp2 = TextEditingController();
    otp3 = TextEditingController();
    otp4 = TextEditingController();

    slipid = TextEditingController();

    super.onInit();
  }

  var balnce;

  var wallet;

  var image;
  void editProf(BuildContext context, phone) async {
    try {
      final isValid = Formkey.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        Formkey.currentState!.save();
        await seteditInfo(context, phone);
      }
    } finally {
      // ignore: todo
      // TODO

    }
  }

  var otps;
  Future<void> seteditInfo(BuildContext context, phone) async {
    openAndCloseLoadingDialog(context);

    otps = otp1.text.toString() +
        otp2.text.toString() +
        otp3.text.toString() +
        otp4.text.toString();

    var data = {
      "phone": phone,
      "confirmation_token": otps,
    };

    inforesponse = await RemoteServices.otp(data);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);

      //  isLoading(false);
    }
  }

  closeDialog(bool stat, String data, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    //
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
                isLoading(false);
                update();
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

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return const LoginScreen();
          },
        ),
      );
    }
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please Provide a FeedBack";
    }
    return null;
  }
}
