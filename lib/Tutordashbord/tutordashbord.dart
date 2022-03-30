// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_null_comparison, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Confirmationcode/confirmationcode.dart';
import 'package:addistutor_tutor/Home/components/course_info_screen.dart';
import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Wallet/wallet.dart';

import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';

import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class TutorDahsbord extends StatefulWidget {
  const TutorDahsbord({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TutorDahsbord>
    with SingleTickerProviderStateMixin {
  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final WalletContoller walletContoller = Get.find();

  final GetReqBooking getReqBooking = Get.put(GetReqBooking());
  @override
  void initState() {
    _fetchUser();

    super.initState();
  }

  void _cheakwallet() async {
    await Future.delayed(const Duration(milliseconds: 5000));

    try {
      int wallet2 = int.parse(walletContoller.wallet.toString());

      if (wallet2 < 100) {
        ScaffoldMessenger.of(editprofileController.keyforall.currentContext!)
            .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 65.0),
          content: const Text('Your wallet has insufficient balance.'),
          duration: const Duration(days: 1),
          backgroundColor: kPrimaryColor,
          action: SnackBarAction(
              label: 'Press here to top up',
              textColor: kPrimaryLightColor,
              onPressed: () {
                Get.to(WalletPage());
              }),
        ));
      } else {
        ScaffoldMessenger.of(editprofileController.keyforall.currentContext!)
            .hideCurrentSnackBar();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  // ignore: prefer_typing_uninitialized_variables
  var ids;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        setState(() {
          ids = int.parse(body["teacher_id"]);
          getReqBooking.fetchReqBooking(body["teacher_id"]);
          getReqBooking.isfetchedsubject(true);
          walletContoller.getbalance(ids);

          _cheakwallet();
        });

        print("yes Id");
      } else {
        print("no Id");
      }
    } else {
      print("no Token");
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      _fetchUser();
      //  _cheakwallet();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  var balancewallet = 10;

  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    return Obx(() => getReqBooking.isfetchedsubject.value
        ? Container(
            color: DesignCourseAppTheme.nearlyWhite,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,

              //cheak pull_to_refresh
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: WillPopScope(
                  onWillPop: _onBackPressed,
                  child: Scaffold(
                      key: editprofileController.keyforall,
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          getAppBarUI(),
                          _buildDivider(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height - 60,
                                child: Column(
                                  children: <Widget>[
                                    Flexible(
                                      child: getPopularCourseUI(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ),
          )
        : Center(
            child: Padding(
            padding: const EdgeInsets.only(top: 406),
            child: Column(children: [
              // CircularProgressIndicator(),
              Center(child: Text("No Reqested Tutor list"))
            ]),
          )));
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.green,
                fontFamily: 'WorkSans',
              ),
            ),
            content: const Text(
              'Are You Sure you want to exit This app?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'WorkSans',
              ),
            ),
            actions: <Widget>[
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FlatButton(
                    onPressed: () {
                      //Navigator.of(context).pop(true);
                      Navigator.pop(context);
                    },
                    child: const Center(child: Text('No')),
                  ),
                  FlatButton(
                    onPressed: () async {
                      //

                      exit(0);
                      //  Navigator.of(context).pop(true);
                    },
                    child: const Center(child: Text('Yes')),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  final Color divider = Colors.grey.shade600;
  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget getPopularCourseUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Pending requests',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.27,
                color: DesignCourseAppTheme.darkerText,
              ),
            ),
            getReqBooking.listsubject.length != 0
                ? SizedBox(
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: getReqBooking.listsubject.length,
                      itemBuilder: (BuildContext context, int index) {
                        final RequestedBooking chat =
                            getReqBooking.listsubject[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    CourseInfoScreen(requestedBooking: chat),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 20.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: const Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(
                                                      "https://tutor.oddatech.com/api/student-profile-picture/${chat.student.id}"))),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          chat.student.first_name +
                                              " " +
                                              chat.student.last_name,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          chat.student.gender,
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            "Grade" " " + chat.student.grade,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: kPrimaryLightColor,
                                            size: 10,
                                          ),
                                          Text(
                                            chat.student.location.name,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                                chat.ended_at != null
                                    ? Column(
                                        children: <Widget>[
                                          Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: const BoxDecoration(
                                                color: kPrimaryColor,
                                                shape: BoxShape.circle),
                                            alignment: Alignment.center,
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            "Booking Ended",
                                            style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    : getstutus(chat),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 320,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'No request yet',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                        ]),
                  ),
          ],
        ),
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Tutor',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Dashboard',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => CodeScreen(),
                ),
              );
            },
            child: Column(children: [
              Text(
                'Scan QR code',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.darkerText,
                ),
              ),
              Icon(
                Icons.qr_code_2,
                color: kPrimaryColor,
              ),
            ]),
          )
        ],
      ),
    );
  }

  getstutus(RequestedBooking chat) {
    return chat.is_active == null
        ? Column(
            children: <Widget>[
              Container(
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                    color: Colors.yellow, shape: BoxShape.circle),
                alignment: Alignment.center,
              ),
              const SizedBox(height: 5.0),
              Text(
                "Pending",
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        : chat.is_active != "0"
            ? Column(
                children: <Widget>[
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Accepted",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Declined",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
