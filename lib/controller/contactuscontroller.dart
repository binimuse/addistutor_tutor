// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:get/get.dart';

class ContactUSContolller extends GetxController with StateMixin {
  var isfetchedsubject = false.obs;

  var contact;

  var name;
  var phone;
  var phone2;
  var email;
  var facebook;
  var twitter;
  var instagram;
  var linkedin;

  void getcontact() async {
    contact = await RemoteServices.contactus();

    if (contact != null) {
      name = contact!.name.toString();
      phone = contact!.phone.toString();
      phone2 = contact!.phone2.toString();
      email = contact!.email.toString();
      facebook = contact!.facebook.toString();
      twitter = contact!.twitter.toString();
      instagram = contact!.instagram.toString();
      linkedin = contact!.linkedin.toString();

      isfetchedsubject(true);
    }
  }
}
