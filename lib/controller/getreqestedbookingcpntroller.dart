import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetReqBooking extends GetxController with StateMixin {
  var listsubject = <RequestedBooking>[].obs;
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  var ratings;

  var isLoading = false.obs;
  void fetchReqBooking(var b_id) async {
    listsubject.value = await RemoteServices.getrequestedbooking(b_id, "");

    if (listsubject.isNotEmpty) {
      //print(list.length.toString());
      isfetchedsubject(true);
      print("am here");
    }
  }

  // var edited = "";
  // Future<void> rating(context, b_id) async {
  //   openAndCloseLoadingDialog(context);

  //   var data = {
  //     "rating": ratings,
  //   };
  //   print(data);
  //   edited = await RemoteServices.rating(data, b_id);
  //   //print(edited.toString());
  //   if (edited.toString() == "200") {
  //     closeDialogpassword(true, edited, context);
  //     isLoading(false);
  //     print("yess");
  //   } else {
  //     //inforesponse = edited;
  //     closeDialogpassword(false, edited, context);
  //     print("noo");
  //     //  print(edited.toString());
  //   }
  // }

  // closeDialogpassword(bool stat, String data, BuildContext context) {
  //   Future.delayed(const Duration(seconds: 1));
  //   // Dismiss CircularProgressIndicator
  //   Navigator.of(context).pop();
  //   if (stat == false) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text(
  //           'Rating  Not Updated \n ' + data.toString(),
  //           style: TextStyle(
  //             fontSize: 13,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black,
  //             fontFamily: 'WorkSans',
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             onPressed: () async {
  //               Navigator.of(context).pop(true);
  //               Navigator.pop(context);
  //               isLoading(false);
  //             },
  //             child: new Text('ok'),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     // ignore: deprecated_member_use

  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text(
  //           'Rating Edited',
  //           style: TextStyle(
  //             fontSize: 13,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black,
  //             fontFamily: 'WorkSans',
  //           ),
  //         ),
  //         actions: <Widget>[
  //           // ignore: deprecated_member_use
  //           FlatButton(
  //             onPressed: () async {
  //               isLoading(false);
  //               Navigator.of(context).pop(true);

  //               Navigator.pop(context);
  //               isLoading(false);
  //               //    openAndCloseLoadingDialog(context);
  //               print("yess");
  //             },
  //             child: new Text('ok'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // void openAndCloseLoadingDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierColor: Colors.grey.withOpacity(0.3),
  //     builder: (_) => WillPopScope(
  //       onWillPop: () async => false,
  //       child: const Center(
  //         child: SizedBox(
  //           width: 30,
  //           height: 30,
  //           child: CircularProgressIndicator(
  //             color: kPrimaryColor,
  //             strokeWidth: 8,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
