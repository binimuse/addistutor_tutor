// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_null_comparison, duplicate_ignore, deprecated_member_use

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EndBookingContoller extends GetxController with StateMixin {
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController ammount;
  late TextEditingController slipid;
  var isfetchedsubject = false.obs;
  var inforesponse;
  var isLoading = false.obs;
  var isFetched = false.obs;
  @override
  void onInit() {
    ammount = TextEditingController();
    slipid = TextEditingController();

    super.onInit();
  }

  var listtransaction = <Transaction>[].obs;
  var isfetchedtransaction = false.obs;

  var balnce;

  var wallet;

  var image;
  void editProf(BuildContext context, reason, b_id) async {
    try {
      final isValid = Formkey.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        Formkey.currentState!.save();
        await seteditInfo(context, reason, b_id);
      }
    } finally {
      // ignore: todo
      // TODO

    }
  }

  Future<void> seteditInfo(BuildContext context, reason, b_id) async {
    openAndCloseLoadingDialog(context);

    inforesponse = await RemoteServices.endbooking(reason, b_id);

    if (inforesponse == true) {
      // fetchReplay(id);
      isfetchedsubject(true);
      closeDialog2(inforesponse, context);
      isLoading(false);
    } else {
      closeDialog2(inforesponse, context);
    }
  }

  closeDialog2(inforesponse, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    //
    print("object");
    Navigator.of(context).pop();
    if (inforesponse == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "End session failed",
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

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'End session Sucess',
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
      return "please Provide a FeedBack";
    }
    return null;
  }
}
