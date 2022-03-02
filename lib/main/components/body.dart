import 'package:addistutor_tutor/Appointment/components/appointmentscreen.dart';

import 'package:addistutor_tutor/Notification/notification.dart';
import 'package:addistutor_tutor/Profile/profile.dart';
import 'package:addistutor_tutor/Tutordashbord/tutordashbord.dart';
import 'package:addistutor_tutor/main/components/bottom_navigation_item.dart';
import 'package:addistutor_tutor/main/components/icons_app.dart';
import 'package:flutter/material.dart';

import 'package:tuple/tuple.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

int _currentTabIndex = 0;

class _BottomNavPageState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);

  List<Tuple2<String, String>> tabsIcons = [
    const Tuple2(IconsApp.icHome, IconsApp.icHomeSelected),
    const Tuple2(IconsApp.icSearch, IconsApp.icSearchSelected),
    const Tuple2(IconsApp.icFavorite, IconsApp.icFavoriteSelected),
    const Tuple2(IconsApp.icAccount, IconsApp.icAccountSelected),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (index <= 0) {
            setState(() {
              _currentTabIndex = index;
            });
          } else {
            setState(() {
              _currentTabIndex = index + 0;
            });
          }
        },
        children: const <Widget>[
          // HomeScreen(),
          // SearchScreen(),
          TutorDahsbord(),
          AppointmentScreen(),

          Notificationclass(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 3,
        color: Theme.of(context).bottomAppBarColor,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                border: Border(top: Divider.createBorderSide(context))),
            height: 56,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[0], 0 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 0;
                    _pageController.jumpToPage(0);
                  });
                })),
                Expanded(
                  child: BottomNavigationItem(
                      tabsIcons[1], 1 == _currentTabIndex, onPress: () {
                    setState(() {
                      _currentTabIndex = 1;
                      _pageController.jumpToPage(1);
                    });
                  }),
                ),
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[2], 2 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 2;
                    _pageController.jumpToPage(2);
                  });
                })),
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[3], 3 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 3;
                    _pageController.jumpToPage(3);
                  });
                })),
              ],
            ),
          ),
          bottom: true,
        ),
      ),
    );
  }
}
