// ignore_for_file: constant_identifier_names, import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables

import 'package:addistutor_tutor/controller/getnotificationcontoller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

    super.initState();
  }

  List<RequestedBooking> subject = [];
  var ids;

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
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: ActivityItemWidget(
                        data: getNotigicationController.listdate[index],
                      ),
                    );
                  },
                  itemCount: getNotigicationController.listdate.length,
                )),
          )
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
