// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_null_comparison, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Confirmationcode/confirmationcode.dart';
import 'package:addistutor_tutor/Home/components/course_info_screen.dart';
import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';

import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/getmypernalityscontroller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';

import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class Mypernality extends StatefulWidget {
  const Mypernality({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Mypernality>
    with SingleTickerProviderStateMixin {
  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final GetPenalitycontoller getPenality = Get.put(GetPenalitycontoller());
  @override
  void initState() {
    getPenality.fetchReqBooking();

    super.initState();
  }

  // ignore: prefer_typing_uninitialized_variables

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      getPenality.fetchReqBooking();
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
    return Container(
        color: DesignCourseAppTheme.nearlyWhite,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,

          //cheak pull_to_refresh
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Material(
                  color: Colors.white,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: const Text(
                  "My penality",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              body: Obx(() => getPenality.isfetchedsubject.value
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
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
                    )
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 406),
                      child: Column(children: [
                        // CircularProgressIndicator(),
                        Center(child: Text("No Penalties"))
                      ]),
                    )))),
        ));
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
        padding: const EdgeInsets.only(top: 18.0, left: 18, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getPenality.listsubject.length != 0
                ? SizedBox(
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: getPenality.listsubject.length,
                      itemBuilder: (BuildContext context, int index) {
                        final GetPenalties penalties =
                            getPenality.listsubject[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push<dynamic>(
                            //   context,
                            //   MaterialPageRoute<dynamic>(
                            //     builder: (BuildContext context) =>
                            //         CourseInfoScreen(requestedBooking: chat),
                            //   ),
                            // );
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
                                        CircleAvatar(
                                            child: FaIcon(
                                              FontAwesomeIcons.userInjured,
                                              color: kPrimaryLightColor,
                                            ), // Icon widget changed with FaIcon
                                            radius: 15.0,
                                            backgroundColor: kPrimaryColor),
                                      ],
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "BOOKING: " " " +
                                              penalties.student_name,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Reason: " " " +
                                              penalties.penalty.description,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                            color: kPrimaryLightColor,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Amount: " " " +
                                              penalties.penalty.amount,
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.clock,
                                      color: kPrimaryLightColor,
                                      size: 18,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      penalties.readable_date,
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5),
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 120,
                    child: Center(
                      child: Text(
                        'No penalties  found',
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
                'Scan Qr',
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
