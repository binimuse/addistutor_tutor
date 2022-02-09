// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print, duplicate_ignore

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class GetReqBooking extends GetxController with StateMixin {
  var listsubject = <RequestedBooking>[].obs;
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  var ratings;

  RequestedBooking? chat;

  var isLoading = false.obs;
  void fetchReqBooking(var bId) async {
    listsubject.value = await RemoteServices.getrequestedbooking(bId, "");

    if (listsubject.isNotEmpty) {
      //print(list.length.toString());
      isfetchedsubject(true);
    }
  }

  var statuss;

  var edited = "";
  Future<void> updateStatus(context, bId) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "status": statuss,
    };

    edited = await RemoteServices.updatestatus(data, bId);
    //print(edited.toString());
    if (edited.toString() == "200") {
      closeDialogpassword(true, edited, context);
      isLoading(false);
    } else {
      //inforesponse = edited;
      closeDialogpassword(false, edited, context);

      //  print(edited.toString());
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
            'Status  Not Updated \n ' + data.toString(),
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
            'Status Updated',
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
