// ignore_for_file: empty_catches, non_constant_identifier_names

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetSubect extends GetxController with StateMixin {
  RxList<Subjects> listSubject = List<Subjects>.of([]).obs;
  final listSubjectvalue = Rxn<Subjects>();
  final listSubjectvalue_e = Rxn<Subjects>();
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  Subjects? subject;

  late List<Subjects> subjectcan;

  var listlocation2 = <Subjects2>[].obs;
  var isfetchedlocation2 = false.obs;
  var sent2 = false.obs;
  Subjects2? subject2;

  void fetchLocation(var id) async {
    listSubject.value.clear();
    try {
      listSubject.value = await RemoteServices.getsubject(id);

      if (listSubject.isNotEmpty) {
        //  print(listlocation.length.toString());
        update();
        isfetchedlocation(true);
      }
    } catch (e) {}
  }

  void setSubectStatus(Subjects zonemodel) {
    listSubjectvalue.value = zonemodel;
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

  void setSubectStatus_e(Subjects zonemodel) {
    listSubjectvalue_e.value = zonemodel;
  }
}
