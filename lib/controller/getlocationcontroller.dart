// ignore_for_file: non_constant_identifier_names, empty_catches

import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:get/get.dart';

class GetLocationController extends GetxController with StateMixin {
  RxList<GetLocation> listlocation = List<GetLocation>.of([]).obs;
  final listlocationvalue = Rxn<GetLocation>();
  final listlocationvalue_gu = Rxn<GetLocation>();
  final listlocationvalue_e = Rxn<GetLocation>();
  final listlocationvalue_location = Rxn<GetLocation>();
  var isfetchedlocation = false.obs;
  var sent = false.obs;

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
    } catch (e) {
     
    }
  }

  void setLocationStatus(GetLocation zonemodel) {
    listlocationvalue.value = zonemodel;
  }

  void setLocationStatusgu(GetLocation zonemodel) {
    listlocationvalue_gu.value = zonemodel;
  }

  void setLocationStatuse(GetLocation zonemodel) {
    listlocationvalue_e.value = zonemodel;
  }

  void setLocationStatuslocation(GetLocation zonemodel) {
    listlocationvalue_location.value = zonemodel;
  }
}
