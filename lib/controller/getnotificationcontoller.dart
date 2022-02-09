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
