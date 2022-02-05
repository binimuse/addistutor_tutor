import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class ContactUSContolller extends GetxController with StateMixin {
  var isfetchedsubject = false.obs;

  var contact;

  var name;
  var phone;
  var email;

  void getcontact() async {
    contact = await RemoteServices.contactus();

    if (contact != null) {
      name = contact!.name.toString();
      phone = contact!.phone.toString();
      email = contact!.email.toString();

      isfetchedsubject(true);
    }
  }
}
