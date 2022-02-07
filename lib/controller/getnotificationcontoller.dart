import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class GetNotigicationController extends GetxController with StateMixin {
  var listdate = <Notifications>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;

  void fetchNotfication() async {
    listdate.value = await RemoteServices.getActivity();

    if (listdate.isNotEmpty) {
      print(listdate.length.toString());

      //  isfetchedlocation(true);

      isfetchedlocation(true);
    }
  }

  RequestedBooking? chat;
  late List<RequestedBooking> subject;
  var listreq = <RequestedBooking>[].obs;
  var isfetchedsreq = false.obs;

  var statuss;

  var isLoading = false.obs;
  void fetchReqBooking(var b_id) async {
    listreq.value = await RemoteServices.getrequestedbooking(b_id, "");

    if (listreq.isNotEmpty) {
      subject = listreq;
      //print(list.length.toString());
      isfetchedsreq(true);
      print("am here");
    }
  }

  var edited = "";
  Future<void> updateStatus(context, b_id) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "status": statuss,
    };
    print(data);
    edited = await RemoteServices.updatestatus(data, b_id);
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
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                isLoading(false);
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
              child: new Text('ok'),
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
