// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:addistutor_tutor/Home/components/course_info_screen.dart';
import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';

import 'package:addistutor_tutor/controller/getnotificationcontoller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activity_item_widget.dart';

class Notificationclass extends StatefulWidget {
  static const ROUTE_NAME = 'ActivityPage';

  const Notificationclass({Key? key}) : super(key: key);
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<Notificationclass>
    with AutomaticKeepAliveClientMixin {
  GetNotigicationController getNotigicationController =
      Get.put(GetNotigicationController());

  final GetReqBooking getReqBooking = Get.put(GetReqBooking());
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      getNotigicationController.fetchNotfication();
    });
    _fetchUser();
    super.initState();
  }

  List<RequestedBooking> subject = [];
  var ids;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        setState(() {
          getNotigicationController.isfetchedsreq(true);
          ids = int.parse(body["teacher_id"]);
          subject = getNotigicationController.listreq;

          try {
            getNotigicationController.chat = subject[0];
          } catch (e) {}
        });
        getNotigicationController.fetchReqBooking(ids);
      } else {}
    } else {}
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      getNotigicationController.fetchNotfication();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Obx(() => getNotigicationController.isfetchedlocation.value
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Notification",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
              ),
            ),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,

              //cheak pull_to_refresh
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: getNotigicationController.isfetchedlocation.isTrue
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    CourseInfoScreen(),
                              ),
                            );
                          },
                          child: ActivityItemWidget(
                            data: getNotigicationController.listdate[index],
                          ),
                        );
                      },
                      itemCount: getNotigicationController.listdate.length,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }

  @override
  bool get wantKeepAlive => true;
}
