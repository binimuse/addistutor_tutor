import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class Getqulificationcontroller extends GetxController with StateMixin {
  RxList<GetQulification> listQulification = List<GetQulification>.of([]).obs;
  final listQulificationvalue = Rxn<GetQulification>();
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  GetQulification? qualification;
  void fetchLocation() async {
    listQulification.value = await RemoteServices.getqualification();

    if (listQulification.isNotEmpty) {
      //print(list.length.toString());
      isfetchedlocation(true);
    }
  }

  void setLevelStatus(GetQulification zonemodel) {
    listQulificationvalue.value = zonemodel;
  }
}
