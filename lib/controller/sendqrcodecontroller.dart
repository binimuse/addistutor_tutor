import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class SendQrcode extends GetxController with StateMixin {
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  var scannedqrcode;

  var isLoading = false.obs;
  var qrcode = "";

  Future<void> qr(context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "data": qrcode,
    };
    print(data);
    qrcode = await RemoteServices.qrcode(data);
    //print(edited.toString());
    if (qrcode.toString() == "200") {
      closeDialogpassword(true, qrcode, context);
      isLoading(false);
      print("yess");
    } else {
      //inforesponse = edited;
      closeDialogpassword(false, qrcode, context);
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
            'Attendance Already created',
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
                //  Navigator.pop(context);
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
            'Attendance Successfuly created',
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

class Dateandtime {
  String date;
  String time;

  Dateandtime(this.date, this.time);

  Map toJson() {
    return {
      'day': date,
      'time': time,
    };
  }
}
