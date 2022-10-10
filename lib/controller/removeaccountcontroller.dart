// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, duplicate_ignore

import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/Profile/getmyaccount.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/controller/contactuscontroller.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/endbookingcontroller.dart';
import 'package:addistutor_tutor/controller/feedbackcontroller.dart';
import 'package:addistutor_tutor/controller/getlevelcontroller.dart';
import 'package:addistutor_tutor/controller/getmypernalityscontroller.dart';
import 'package:addistutor_tutor/controller/getnotificationcontoller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/controller/sendqrcodecontroller.dart';
import 'package:addistutor_tutor/controller/signupcontroller.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'avlablityconroller.dart';
import 'updateprofilecontroller.dart';

class RemoveScreencontroller extends GetxController with StateMixin {
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController feedback;
  var inforesponse;
  var isLoading = false.obs;
  var isFetched = false.obs;
  @override
  void onInit() {
    feedback = TextEditingController();

    super.onInit();
  }

  Future<void> seteditInfo(BuildContext context, id) async {
    openAndCloseLoadingDialog(context);

    inforesponse = await RemoteServices.remove(id);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');
      Get.delete<SignupController>();
      Get.delete<EditprofileController>();
      Get.delete<Avalablitycontrollerclass>();
      Get.delete<ContactUSContolller>();
      Get.delete<FeedBackScreencontroller>();
      Get.delete<WalletContoller>();
      Get.delete<SendQrcode>();
      Get.delete<GetReqBooking>();
      Get.delete<GetNotigicationController>();
      Get.delete<GetLevelContoller>();
      Get.delete<Updateprofilecontoller>();
      Get.delete<GetPenalitycontoller>();
      Get.delete<EndBookingContoller>();
      Get.delete<GetmyAccount>();

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');
      Get.delete<SignupController>();
      Get.delete<EditprofileController>();
      Get.delete<Avalablitycontrollerclass>();
      Get.delete<ContactUSContolller>();
      Get.delete<FeedBackScreencontroller>();
      Get.delete<WalletContoller>();
      Get.delete<SendQrcode>();
      Get.delete<GetReqBooking>();
      Get.delete<GetNotigicationController>();
      Get.delete<GetLevelContoller>();
      Get.delete<Updateprofilecontoller>();
      Get.delete<GetPenalitycontoller>();
      Get.delete<EndBookingContoller>();
      Get.delete<GetmyAccount>();

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginScreen(),
          transitionDuration: Duration.zero,
        ),
      );
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
          title: const Text(
            'Remove account Error',
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
            'Successfully Removed. ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                isLoading(false);
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ProfileScreen()),
                // );
              },
              child: const Text('ok'),
            ),
          ],
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
      return "please provide a Feedback";
    }
    return null;
  }
}
