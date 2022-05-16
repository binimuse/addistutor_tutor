// ignore_for_file: non_constant_identifier_names, empty_catches

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetLocationController extends GetxController with StateMixin {
  var listlocation = <GetLocation>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  GetLocation? getLocation;
  GetLocation? subcity;
  GetLocation? g_subcity;
  GetLocation? e_subcity;

  void fetchLocation() async {
    try {
      listlocation.value = await RemoteServices.getlocation();

      if (listlocation.isNotEmpty) {
        //print(list.length.toString());
        isfetchedlocation(true);
      }
    } catch (e) {}
  }
}
