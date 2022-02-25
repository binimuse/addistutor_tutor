import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class Getqulificationcontroller extends GetxController with StateMixin {
  var listlocation = <GetQulification>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  GetQulification? qualification;
  void fetchLocation() async {
    listlocation.value = await RemoteServices.getqualification();

    if (listlocation.isNotEmpty) {
      //print(list.length.toString());
      isfetchedlocation(true);
    }
  }
}
