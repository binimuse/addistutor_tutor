// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, duplicate_ignore

import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';

class FeedBackScreencontroller extends GetxController with StateMixin {
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

  void editProf(BuildContext context) async {
    try {
      final isValid = Formkey.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        Formkey.currentState!.save();
        await seteditInfo(context);
      }
    } finally {
      // ignore: todo
      // TODO

    }
  }

  Future<void> seteditInfo(BuildContext context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "message": feedback.text,
    };
    inforesponse = await RemoteServices.feedback(data);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);
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
            'FeedBack Error',
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
            'Successfully recorded. Thank you for your feedback.',
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
