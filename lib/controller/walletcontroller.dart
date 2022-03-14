// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_null_comparison, duplicate_ignore, deprecated_member_use

import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';

class WalletContoller extends GetxController with StateMixin {
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController ammount;
  late TextEditingController slipid;

  var inforesponse;
  var isLoading = false.obs;
  var isFetched = false.obs;
  @override
  void onInit() {
    ammount = TextEditingController();
    slipid = TextEditingController();

    super.onInit();
  }

  var listtransaction = <Transaction>[].obs;
  var isfetchedtransaction = false.obs;

  void gettransaction(var id) async {
    listtransaction.value = await RemoteServices.transaction(id);
    if (listtransaction != null) {
      isfetchedtransaction(true);
    }
  }

  var balnce;

  var wallet;

  void getbalance(var id) async {
    balnce = await RemoteServices.balance(id);

    if (balnce != null) {
      // balnce = balance;
      // ignore: unnecessary_null_comparison
      wallet = balnce!.wallet_amount.toString();
      update();
      isFetched(true);
    }
  }

  var image;
  void editProf(BuildContext context, id) async {
    try {
      final isValid = Formkey.currentState!.validate();

      if (isValid == true && image != null) {
        isLoading(true);
        Formkey.currentState!.save();
        await seteditInfo(context, image, id);
      }
    } finally {
      // ignore: todo
      // TODO

    }
  }

  Future<void> seteditInfo(BuildContext context, image, id) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "slip_id": slipid.text,
      "amount": ammount.text,
    };

    inforesponse = await RemoteServices.wallet(image, data, id);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);

      //  isLoading(false);
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
          title: Text(
            data.toString(),
            style: const TextStyle(
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
                Navigator.pop(context);
              },
              child: const Text('OK'),
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
            'Thank you for making the deposit. The administrator is verifying your deposit. Please wait.',
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
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide a FeedBack";
    }
    return null;
  }
}
