import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Home/components/singlebooingpage.dart';
import 'package:addistutor_tutor/Wallet/wallet.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constants.dart';

class ActivityItemWidget extends StatefulWidget {
  final Notifications? data;
  const ActivityItemWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final GetReqBooking requestedBooking = Get.put(GetReqBooking());

class _ProfileScreenState extends State<ActivityItemWidget>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();

    super.initState();
  }

  var bid;

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity1 = 1.0;
      });
    }

    await Future<dynamic>.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      setState(() {
        opacity2 = 1.0;
      });
    }

    await Future<dynamic>.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      setState(() {
        opacity3 = 1.0;
      });
    }
  }

  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Row(
              children: <Widget>[
                const Icon(Icons.notification_add, color: kPrimaryColor),
                widget.data!.data.message == "Booking accepted"
                    ? Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: widget.data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " from student  " +
                                      widget.data!.data.student_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + widget.data!.created_at,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ))
                            ]))))
                    : widget.data!.data.notification_type == "wallet"
                        ? Expanded(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: widget.data!.data.message,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkText,
                                      )),
                                  TextSpan(
                                      text: " " + widget.data!.created_at,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.grey,
                                      )),
                                ]))))
                        : Expanded(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: widget.data!.data.message,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkText,
                                      )),
                                  TextSpan(
                                      text: "\nby " +
                                          widget.data!.data.teacher_name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkText,
                                      )),
                                  TextSpan(
                                      text: " " + widget.data!.created_at,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.grey,
                                      )),
                                ])))),
              ],
            ),
          ),
          onTap: () async {
            if (widget.data!.data.notification_type == "wallet") {
              Get.to(() => WalletPage());
            } else {
              setState(() {
                requestedBooking.getsingle(widget.data!.data.booking_id);
              });
              loadData();
              await Future.delayed(const Duration(seconds: 2));
            }
          },
        ));
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(seconds: 2), () {
// Here you can write your code
      Get.to(SinglebookingPage(hotelData: widget.data!.data.booking_id));
      EasyLoading.dismiss();
    });
  }
}
