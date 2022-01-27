import 'dart:convert';

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:addistutor_tutor/controller/avlablityconroller.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weekday_selector/weekday_selector.dart';
import '../constants.dart';

class AvalablityScreen extends StatefulWidget {
  const AvalablityScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

var ids;

class _FeedbackScreenState extends State<AvalablityScreen> {
  final Avalablitycontrollerclass avalablitycontrollerclass =
      Get.put(Avalablitycontrollerclass());

  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    _fetchUser();
    _fetchdays();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      _fetchUser();
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

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        ids = int.parse(body["teacher_id"]);
        editprofileController.fetchPf(int.parse(body["teacher_id"]));
      } else {
        var noid = "noid";
        print("no Id");
        editprofileController.fetchPf(noid);
      }
    } else {
      print("no Token");
    }

    if (editprofileController.isActive == "1") {
      isSelected = [true, false];
    } else {
      isSelected = [false, true];
    }
  }

  void _fetchdays() async {
    avalablitycontrollerclass.fetchPf();
  }

  final values = <bool?>[false, false, false, false, false, false, false];
  bool ismonday = false;
  bool istue = false;
  bool iswen = false;
  bool isthe = false;
  bool isfri = false;
  bool issat = false;
  bool issun = false;

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
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
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
                    "Tutor Availability",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'select your available date to give a tutor',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        WeekdaySelector(
                            selectedFillColor: kPrimaryColor,
                            onChanged: (v) {
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

                                avalablitycontrollerclass.Wed.text =
                                    "Wednesday";
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
                        const SizedBox(height: 20),
                        ismonday
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Mon,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        istue
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Tue,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        iswen
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Wed,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        isthe
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Thu,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        isfri
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Fri,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        issat
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Sat,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        issun
                            ? TextFormField(
                                controller: avalablitycontrollerclass.Sun,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  enabled: false,
                                  focusColor: kPrimaryColor,
                                  fillColor: kPrimaryColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  return avalablitycontrollerclass
                                      .validateName(value!);
                                },
                              )
                            : Container(),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'select your availability ',
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
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Available',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Temporarily unavailable',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                    }

                                    avalablitycontrollerclass.isa =
                                        isSelected[0];

                                    print(avalablitycontrollerclass.isa);
                                  });
                                },
                                isSelected: isSelected,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  // print("bin");
                                  // print(id);
                                  avalablitycontrollerclass.editProf(
                                      context, ids.toString());
                                },
                                color: kPrimaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
    );
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
}
