// ignore_for_file: constant_identifier_names

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:flutter/material.dart';

import 'activity_item_widget.dart';

class Notificationclass extends StatefulWidget {
  static const ROUTE_NAME = 'ActivityPage';

  const Notificationclass({Key? key}) : super(key: key);
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<Notificationclass>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Notification",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'WorkSans',
              ),
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => const ActivityItemWidget(),
            itemCount: 20,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
