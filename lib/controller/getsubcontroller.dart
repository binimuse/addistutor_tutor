// ignore_for_file: empty_catches

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetSubect extends GetxController with StateMixin {
  var listlocation = <Subjects>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  Subjects? subject;

  late List<Subjects> subjectcan;

  var listlocation2 = <Subjects2>[].obs;
  var isfetchedlocation2 = false.obs;
  var sent2 = false.obs;
  Subjects2? subject2;

  void fetchLocation(var id) async {
    //print(id);
    listlocation.value = await RemoteServices.getsubject(id);

    if (listlocation.isNotEmpty) {
      //  print(listlocation.length.toString());
      update();
      isfetchedlocation(true);
    }
  }

  void fetchLocation2() async {
    try {
      listlocation2.value = await RemoteServices.getsubject2();

      if (listlocation2.isNotEmpty) {
        //  print(listlocation.length.toString());
        update();
        isfetchedlocation2(true);
      }
    } catch (e) {}
    //print(id);
  }
}
