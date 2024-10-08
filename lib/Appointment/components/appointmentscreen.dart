// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Appointment/components/ongoingtutors.dart';
import 'package:addistutor_tutor/Home/components/category_list_view.dart';
import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Appointment(),
    );
  }
}

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _fetchUser();
      // _cheakwallet();
      walletContoller.isFetched(true);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 100));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
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
          ids = body["teacher_id"];
          walletContoller.getbalance(ids);
        });
        // _cheakwallet();
        print("yes Id");
      } else {
        print("no Id");
      }
    } else {
      print("no Token");
    }
  }

  // void _cheakwallet() async {
  //   await Future.delayed(const Duration(milliseconds: 1000));
  //   print(walletContoller.wallet.toString());
  //   int wallet2 = int.parse(walletContoller.wallet.toString());

  //   if (wallet2 < 100) {
  //     ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
  //       content: const Text('Your wallet amount is less'),
  //       duration: const Duration(seconds: 10),
  //       backgroundColor: kPrimaryColor,
  //       action: SnackBarAction(
  //           label: 'Press here to top up amount',
  //           textColor: kPrimaryLightColor,
  //           onPressed: () {
  //             Get.to(WalletPage());
  //           }),
  //     ));
  //   } else {
  //     ScaffoldMessenger.of(_scaffoldKey.currentContext!).hideCurrentSnackBar();
  //   }
  // }

  var balancewallet = 10;

  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,

        //cheak pull_to_refresh
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Container(
            color: DesignCourseAppTheme.nearlyWhite,
            child: WillPopScope(
                onWillPop: _onBackPressed,
                child: Obx(
                  () => walletContoller.isFetched.value
                      ? Scaffold(
                          key: _scaffoldKey,
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: <Widget>[
                              SizedBox(
                                height: MediaQuery.of(context).padding.top,
                              ),
                              // getAppBarUI(),
                              _buildDivider(),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: <Widget>[
                                      getCategoryUI(),
                                      Flexible(
                                        child: getPopularCourseUI(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ))));
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
              'Are you sure you want to exit this app?',
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

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 20.0, left: 18, right: 16),
          child: Text(
            'Top rated tutors ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CategoryListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
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
              'Ongoing sessions',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.27,
                color: DesignCourseAppTheme.darkerText,
              ),
            ),
            OnGoingTutors(
              callBack: () {
                moveTo();
              },
            ),
          ],
        ),
      ),
    );
  }

  void moveTo() {}

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
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
                  'Welcome to',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'NextGen',
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
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  walletContoller.wallet.toString().obs + ' birr',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                    letterSpacing: 0.2,
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                  'Available Balance',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
              ]),
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
