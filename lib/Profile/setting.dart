import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/changepassword.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class SettingsFourPage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings4.dart";

  @override
  _SettingsFourPageState createState() => _SettingsFourPageState();
}

bool isActive = true;

final List locale = [
  {'name': 'English', 'locale': const Locale('en', 'US')},
  {'name': 'Hindi', 'locale': const Locale('hi', 'IN')},
  {'name': 'Arabic', 'locale': const Locale('ar', 'IN')},
  {'name': 'Amahric', 'locale': const Locale('am', 'IN')},
  {'name': 'deutch', 'locale': const Locale('de', 'IN')},
  {'name': 'Espaoal', 'locale': const Locale('es', 'IN')},
  {'name': 'French', 'locale': const Locale('fr', 'IN')},
  {'name': 'Indonesia', 'locale': const Locale('in', 'IN')},
  {'name': 'China', 'locale': const Locale('ch', 'IN')},
  {'name': 'Malaysia', 'locale': const Locale('ma', 'IN')},
  {'name': 'Turkia', 'locale': const Locale('tu', 'IN')},
  {'name': 'Italia', 'locale': const Locale('it', 'IN')},
  {'name': 'portugal', 'locale': const Locale('po', 'IN')},
  {'name': 'Somlia', 'locale': const Locale('so', 'IN')},
];
updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}

class _SettingsFourPageState extends State<SettingsFourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Material(
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
            child: Icon(
              Icons.arrow_back_ios,
              color: DesignCourseAppTheme.nearlyBlack,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  // ignore: prefer_const_constructors
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        ChangePassword(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Change password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                buildLanguageDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildAccountOptionRow(context, "Privacy and Policy"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(Icons.volume_up_outlined, color: kPrimaryColor),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New update", true),
            buildNotificationOptionRow("Account Status", isActive),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        GestureDetector(
          child: Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: isActive,
                onChanged: (bool val) {
                  setState(() {
                    isActive == false;
                  });
                },
              )),
        )
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   // ignore: prefer_const_constructors
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation1, animation2) => ChangePassword(),
        //     transitionDuration: Duration.zero,
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: kPrimaryColor,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
}
