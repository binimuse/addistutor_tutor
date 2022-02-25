import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetLevelContoller extends GetxController with StateMixin {
  var listlocation = <GetLevel>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  GetLevel? level;
  void fetchLocation() async {
    listlocation.value = await RemoteServices.getlevel();

    if (listlocation.isNotEmpty) {
      //print(list.length.toString());
      isfetchedlocation(true);
    }
  }
}
