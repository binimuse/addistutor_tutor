import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetLevelContoller extends GetxController with StateMixin {
  RxList<GetLevel> listlevel = List<GetLevel>.of([]).obs;
  final listlevelvalue = Rxn<GetLevel>();
  var isfetchedlocation = false.obs;
  var sent = false.obs;

  void fetchLocation() async {
    listlevel.value = await RemoteServices.getlevel();

    if (listlevel.isNotEmpty) {
      //print(list.length.toString());
      update();
      isfetchedlocation(true);
    }
  }

  void setLevelStatus(GetLevel zonemodel) {
    listlevelvalue.value = zonemodel;
  }
}
