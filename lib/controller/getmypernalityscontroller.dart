// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print, duplicate_ignore

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class GetPenalitycontoller extends GetxController with StateMixin {
  var listsubject = <GetPenalties>[].obs;
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  var ratings;

  GetPenalties? chat;

  var isLoading = false.obs;
  void fetchReqBooking() async {
    listsubject.value = await RemoteServices.getmypenality();

    if (listsubject.isNotEmpty) {
      //print(list.length.toString());
      isfetchedsubject(true);
    }
  }
}
