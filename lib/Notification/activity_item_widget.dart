import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ActivityItemWidget extends StatelessWidget {
  const ActivityItemWidget({Key? key, this.data, this.callback})
      : super(key: key);
  final Notifications? data;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: callback,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Row(
              children: <Widget>[
                const Icon(Icons.notification_add, color: kPrimaryColor),
                data!.data.message != "You have new booking"
                    ? Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " from student  " +
                                      data!.data.student_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + data!.created_at,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ))
                            ]))))
                    : Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + data!.created_at,
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
        ));
  }
}
