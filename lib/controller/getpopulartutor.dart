// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:get/get.dart';

class GetPopularTutorController extends GetxController with StateMixin {
  var popular;
  var getqr;
  var isfetchedsubject = false.obs;

  void fetchqr() async {
    try {
      popular = await RemoteServices.getpopular();
      if (popular != null) {
        // print("getqr.toString()");
        // print(getqr + "\n" + b_id.toString());
        isfetchedsubject(true);
      }
    } catch (e) {}
  }
}
