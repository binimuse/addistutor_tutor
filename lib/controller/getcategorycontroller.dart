// ignore_for_file: empty_catches

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetCatgroryContoller extends GetxController with StateMixin {
  RxList<GetCategory> listCategory = List<GetCategory>.of([]).obs;
  final listlistCategoryvalue = Rxn<GetCategory>();

  var isfetchedlocation = false.obs;

  Subjects2? subject2;

  void fetchLocation() async {
    //print(id);
    listCategory.value = await RemoteServices.getcategory();

    if (listCategory.isNotEmpty) {
      //  print(listlocation.length.toString());
      update();
      isfetchedlocation(true);
    }
  }

  void setSubectStatus(GetCategory zonemodel) {
    listlistCategoryvalue.value = zonemodel;
  }
}
