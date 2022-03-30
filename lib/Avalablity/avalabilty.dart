// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:addistutor_tutor/controller/avlablityconroller.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weekday_selector/weekday_selector.dart';
import '../constants.dart';

class AvalablityScreen extends StatefulWidget {
  const AvalablityScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

// ignore: prefer_typing_uninitialized_variables
var ids;

class _FeedbackScreenState extends State<AvalablityScreen> {
  final Avalablitycontrollerclass avalablitycontrollerclass =
      Get.put(Avalablitycontrollerclass());

  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  @override
  void initState() {
    super.initState();

    _fetchUser();
    _fetchdays();
  }

  Activedays? day;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    _fetchUser();

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

  bool change = false;

  void _fetchUser() async {
    if (editprofileController.isActive.toString() == "1") {
      avalablitycontrollerclass.isSelected = [true, false];
    } else {
      avalablitycontrollerclass.isSelected = [false, true];
    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        ids = int.parse(body["teacher_id"]);
        editprofileController.fetchPf(int.parse(body["teacher_id"]));
      } else {
        var noid = "noid";

        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  late List<bool?> values = <bool?>[
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> daylist = [
    "Monday",
  ];

  void _fetchdays() async {
    avalablitycontrollerclass.fetchPf();
  }

  bool ismonday = false;
  bool istue = false;
  bool iswen = false;
  bool isthe = false;
  bool isfri = false;
  bool issat = false;
  bool issun = false;
  final selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    // _onRefresh();
    return Obx(() => avalablitycontrollerclass.isFetched.value
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,

            //cheak pull_to_refresh
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Container(
                color: AppTheme.nearlyWhite,
                child: SafeArea(
                    top: false,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      key: avalablitycontrollerclass.scaffoldKey,
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        leading: Material(
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                AppBar().preferredSize.height),
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
                          "Your Availability",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ),
                      backgroundColor: AppTheme.nearlyWhite,
                      body: Form(
                        key: avalablitycontrollerclass.Avalablity,
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              change
                                  ? const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Selected dates',
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    )
                                  : Container(),
                              FutureBuilder(
                                  future: RemoteServices.fetchdaya(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return SizedBox(
                                          height: 100,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (_, index) {
                                                return SizedBox.fromSize(
                                                  size: const Size(76,
                                                      76), // button width and height
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: Colors
                                                          .transparent, // button color
                                                      child: InkWell(
                                                        splashColor:
                                                            kPrimaryColor, // splash color
                                                        onTap: () {
                                                          setState(() {
                                                            change = true;
                                                          });
                                                        }, // button pressed
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            const Icon(
                                                              Icons
                                                                  .date_range_outlined,
                                                              color:
                                                                  kPrimaryColor,
                                                            ), // icon
                                                            Text(
                                                              snapshot
                                                                  .data[index]!
                                                                  .day,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12.0),
                                                            ), // text
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: snapshot.data.length));
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                              change ? selectdate() : Container(),
                              const SizedBox(height: 20),
                              selectavalbily(),
                              const SizedBox(height: 20),
                              change
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // ignore: deprecated_member_use
                                          RaisedButton(
                                            onPressed: () {
                                              // print("bin");
                                              // print(id);
                                              avalablitycontrollerclass
                                                  .editProf(
                                                      context, ids.toString());
                                            },
                                            color: kPrimaryColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Text(
                                              "SAVE",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  letterSpacing: 2.2,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ))))
        : const Center(child: CircularProgressIndicator()));
  }

  printIntAsDay(int day) {
    print(
        'Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
    // if (intDayToEnglish(day) == "Monday") {

    // }

    // a.add(intDayToEnglish(day));

    // // ignore: avoid_print
    // print(a.length);
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tuesday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw '🐞 This should never have happened: $day';
  }

  Widget selectdate() {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Select the dates you prefer for tutoring',
          style: TextStyle(color: Colors.black45),
        ),
      ),
      WeekdaySelector(
          selectedFillColor: kPrimaryColor,
          onChanged: (v) {
            avalablitycontrollerclass.onchangedate(true);
            printIntAsDay(v);

            setState(() {
              values[v % 7] = !values[v % 7]!;
              //    mon;
            });

            print(values);

            if (values[1] == true) {
              ismonday = true;

              avalablitycontrollerclass.Mon.text = "Monday";
            } else if (values[1] == false) {
              ismonday = false;
              avalablitycontrollerclass.Mon.text = "";
            }

            //    thu;
            if (values[2] == true) {
              istue = true;

              avalablitycontrollerclass.Tue.text = "Tuesday";
            } else if (values[2] == false) {
              istue = false;
              avalablitycontrollerclass.Tue.text = "";
            }

            //    Wen;
            if (values[3] == true) {
              iswen = true;

              avalablitycontrollerclass.Wed.text = "Wednesday";
            } else if (values[3] == false) {
              iswen = false;
              avalablitycontrollerclass.Wed.text = "";
            }

            //    The;
            if (values[4] == true) {
              isthe = true;

              avalablitycontrollerclass.Thu.text = "Thursday";
            } else if (values[4] == false) {
              isthe = false;
              avalablitycontrollerclass.Thu.text = "";
            }
            //    fri;
            if (values[5] == true) {
              isfri = true;

              avalablitycontrollerclass.Fri.text = "Friday";
            } else if (values[5] == false) {
              isfri = false;
              avalablitycontrollerclass.Fri.text = "";
            }

            //    sat;
            if (values[6] == true) {
              issat = true;

              avalablitycontrollerclass.Sat.text = "Saturday";
            } else if (values[6] == false) {
              issat = false;
              avalablitycontrollerclass.Sat.text = "";
            }

            if (values[0] == true) {
              issun = true;

              avalablitycontrollerclass.Sun.text = "Sunday";
            } else if (values[0] == false) {
              issun = false;
              avalablitycontrollerclass.Sun.text = "";
            }
          },
          values: values,
          selectedElevation: 15,
          elevation: 5,
          disabledElevation: 0,
          shortWeekdays: const [
            'Sun', // Sunday
            'Mon', // MOONday
            'Tue', // https://en.wikipedia.org/wiki/Names_of_the_days_of_the_week
            'Wed', // I ran out of ideas...
            'Thur', // Thirst-day
            'Fri', // It's Friday, Friday, Gotta get down on Friday!
            'Sat', // Everybody's lookin' forward to the weekend, weekend
          ]),
    ]);
  }

  Widget selectavalbily() {
    _onRefresh();
    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Select your availability ',
          style: TextStyle(color: Colors.black45),
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ToggleButtons(
              borderColor: Colors.black,
              fillColor: kPrimaryColor,
              borderWidth: 2,
              selectedBorderColor: Colors.black,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(0),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Available',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Temporarily unavailable',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  change = true;

                  for (int i = 0;
                      i < avalablitycontrollerclass.isSelected.length;
                      i++) {
                    avalablitycontrollerclass.isSelected[i] = i == index;
                  }
                });

                setState(() {
                  avalablitycontrollerclass.onchange(true);
                  avalablitycontrollerclass.isa =
                      avalablitycontrollerclass.isSelected[0];
                });
              },
              isSelected: avalablitycontrollerclass.isSelected,
            ),
          ],
        ),
      ),
    ]);
  }
}
