// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches, non_constant_identifier_names

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:get/get.dart';

class GetmyAccount extends GetxController with StateMixin {
  var getmy;
  var getqr;
  var isfetchedsubject = false.obs;
  var full_name;
  var phone;
  var email;

  void fetchqr() async {
    try {
      getmy = await RemoteServices.getmyaacount();

      if (getmy != null) {
        full_name = getmy!.full_name.toString();
        email = getmy!.email.toString();
        phone = getmy!.phone.toString();

        isfetchedsubject(true);
      }
    } catch (e) {}
  }
}
