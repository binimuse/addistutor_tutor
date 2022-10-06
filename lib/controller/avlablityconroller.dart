// ignore_for_file: non_constant_identifier_names, duplicate_ignore, deprecated_member_use

import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Avalablitycontrollerclass extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> Avalablity = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: prefer_typing_uninitialized_variables
  var inforesponse;
  var isLoading = false.obs;

  late String days;
  late List<bool> isSelected;
  late TextEditingController Mon;
  late TextEditingController Tue;
  late TextEditingController Wed;
  late TextEditingController Thu;
  late TextEditingController Fri;
  late TextEditingController Sat;
  late TextEditingController Sun;

  late bool isa = false;
  var onchange = false.obs;
  var onchangedate = false.obs;

  @override
  void onInit() {
    Mon = TextEditingController();
    Tue = TextEditingController();
    Wed = TextEditingController();
    Wed = TextEditingController();
    Thu = TextEditingController();
    Fri = TextEditingController();
    Sat = TextEditingController();
    Sun = TextEditingController();

    super.onInit();
  }

  var isFetched = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var fetched;
  // ignore: prefer_typing_uninitialized_variables
  var activedays;

  Future<void> fetchPf() async {
    try {
      //  openAndCloseLoadingDialog();
      fetched = await RemoteServices.fetchdaya();

      //   print(fetched);
      if (fetched != "") {
        isFetched.value = true;

        await Future.delayed(const Duration(seconds: 1));
        // Dismiss CircularProgressIndicator
        //   Navigator.of(Get.context!).pop();
      }
      change(fetched, status: RxStatus.success());
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));

      // ignore: todo
      // TODO

    }
  }

  void editProf(BuildContext context, id) async {
    try {
      if (onchange(true)) {
        isLoading(true);
        Avalablity.currentState!.save();
        await seteditInfo2(context, id);
      }
      if (onchangedate(true)) {
        isLoading(true);
        Avalablity.currentState!.save();
        await seteditInfo(context);
      }
    } finally {
      // ignore: todo
      // TODO
    }
  }

  Future<void> seteditInfo(BuildContext context) async {
    openAndCloseLoadingDialog(context);

    days = Mon.text +
        "," +
        Tue.text +
        "," +
        Wed.text +
        "," +
        Thu.text +
        "," +
        Fri.text +
        "," +
        Sat.text +
        "," +
        Sun.text;

    var data = {
      "days": days.toString(),

//delete
    };
    inforesponse = await RemoteServices.editAvalablitydate(data);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);
    }
  }

  closeDialog(bool stat, String data, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    //
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Availability Not updated.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                isLoading(false);
                Navigator.of(context).pop(true);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    } else {
      // ignore: deprecated_member_use

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Availability updated.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                isLoading(false);
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ProfileScreen()),
                // );
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide a name";
    }
    return null;
  }

  void openAndCloseLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: kPrimaryColor,
              strokeWidth: 8,
            ),
          ),
        ),
      ),
    );
  }

// ignore: prefer_typing_uninitialized_variables
  var datas;
  seteditInfo2(BuildContext context, id) async {
    // openAndCloseLoadingDialog(context);

    if (isa == true) {
      datas = {
        "is_active": 1,
      };
    } else {
      datas = {
        "is_active": 0,
      };
    }

    inforesponse = await RemoteServices.editAvalablity(datas, id);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);

      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);
    }
  }
}
