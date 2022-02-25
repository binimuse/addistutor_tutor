import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetSubect extends GetxController with StateMixin {
  var listlocation = <Subjects>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  Subjects? subject;
  void fetchLocation(var id) async {
    listlocation.value = await RemoteServices.getsubject(id);

    if (listlocation.isNotEmpty) {
      //print(list.length.toString());
      isfetchedlocation(true);
    }
  }
}
