// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, prefer_const_constructors, deprecated_member_use, duplicate_ignore

import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/controller/endbookingcontroller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'design_course_app_theme.dart';

class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({
    Key? key,
    this.requestedBooking,
  }) : super(key: key);
  final RequestedBooking? requestedBooking;
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

final Color divider = Colors.grey.shade600;

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final double _initialRating = 2.0;
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  final bool _isVertical = false;
  bool rating = false;
  IconData? _selectedIcon;

  final GetReqBooking getReqBooking = Get.put(GetReqBooking());
  final EndBookingContoller endBookingContoller =
      Get.put(EndBookingContoller());

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));

    setData();

    _fetchUser();
    super.initState();
  }

  var ids;
  void _fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {});
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.3) +
        24.0;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset('assets/images/lg3.png'),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 18, right: 16),
                            child: Text(
                              "Student info",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                fontFamily: 'WorkSans',
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.requestedBooking!.student.first_name +
                                      " " +
                                      widget
                                          .requestedBooking!.student.last_name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ),
                                ),
                                Text(
                                  widget.requestedBooking!.student.gender,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    "Grade:- ",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      color: kPrimaryColor,
                                      fontFamily: 'WorkSans',
                                      letterSpacing: 0.27,
                                    ),
                                  ),
                                  Text(
                                    widget.requestedBooking!.student.grade,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      fontFamily: 'WorkSans',
                                      letterSpacing: 0.27,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  const Icon(
                                    Icons.location_pin,
                                    color: kPrimaryLightColor,
                                    size: 10,
                                  ),
                                  Text(
                                    widget.requestedBooking!.student.location
                                        .name,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      fontFamily: 'WorkSans',
                                      letterSpacing: 0.27,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          widget.requestedBooking!.is_active == "1"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      const Icon(
                                        Icons.phone,
                                        color: kPrimaryColor,
                                        size: 10,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget
                                            .requestedBooking!.student.phone_no,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 15,
                                          fontFamily: 'WorkSans',
                                          letterSpacing: 0.27,
                                        ),
                                      ),
                                    ])
                              : Container(),
                          widget.requestedBooking!.student.about != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 18, right: 16),
                                  child: Text(
                                    widget.requestedBooking!.student.about,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      fontFamily: 'WorkSans',
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 18, right: 16),
                                  child: Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      fontFamily: 'WorkSans',
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.grey,
                                    ),
                                  ),
                                ),
                          _buildDivider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, left: 18, right: 16),
                            child: Text(
                              "Booking info",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                fontFamily: 'WorkSans',
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(1.toString(), 'Subject'),
                                  getTimeBoxUI(
                                      widget.requestedBooking!.session
                                          .toString(),
                                      'session'),
                                  getTimeBoxUI(
                                      widget.requestedBooking!.sessiontaken
                                          .toString(),
                                      'session taken'),
                                ],
                              ),
                            ),
                          ),
                          getTimeBoxUIday(
                              widget.requestedBooking!.subject.title),
                          const Center(
                            child: Text(
                              "Days Booked",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: [
                                      getTimeBoxUIday(widget.requestedBooking!
                                              .booking_schedule[index].day +
                                          " " +
                                          widget
                                              .requestedBooking!
                                              .booking_schedule[index]
                                              .readable_time),
                                    ],
                                  );
                                },
                                itemCount: widget
                                    .requestedBooking!.booking_schedule.length),
                          ),
                          widget.requestedBooking!.ended_at != null
                              ? AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 20, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: DesignCourseAppTheme
                                                        .nearlyBlue
                                                        .withOpacity(0.5),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 6.0),
                                              ],
                                            ),
                                            child: Center(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Booking ended at : ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        letterSpacing: 0.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.requestedBooking!
                                                          .ended_at,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        letterSpacing: 0.0,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : getstutus(widget.requestedBooking),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                right: 35,
                child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(
                        parent: animationController!,
                        curve: Curves.fastOutSlowIn),
                    child: SizedBox(
                      width: 120,
                      height: 78,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.network(
                            "https://nextgeneducation.et/api/student-profile-picture/${widget.requestedBooking!.student.id}",
                          )),
                    ))),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
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
              ),
            )
          ],
        ));
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget getTimeBoxUIday(String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();
  var valueText;
  Future<void> _displayTextInputDialog(BuildContext context, int id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: endBookingContoller.Formkey,
            child: AlertDialog(
              title: const Text('End Session?'),
              content: TextFormField(
                onChanged: (value) {
                  setState(() {
                    valueText = value;
                  });
                },
                controller: _textFieldController,
                decoration:
                    const InputDecoration(hintText: "Please enter reason"),
                validator: (value) {
                  return endBookingContoller.validateName(value!);
                },
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text('Submit'),
                  onPressed: () async {
                    setState(() {
                      //  codeDialog = valueText;
                      endBookingContoller.editProf(context, valueText, id);
                    });
                    await Future<dynamic>.delayed(
                        const Duration(milliseconds: 2000));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  final Color active = Colors.grey.shade800;
  buildRow(
    IconData icon,
    String title,
  ) {
    final TextStyle tStyle =
        TextStyle(color: active, fontSize: 16.0, fontFamily: "WorkSans");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: kPrimaryColor,
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        const Spacer(),
      ]),
    );
  }

  giverating() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: Colors.amber.withAlpha(50),
            itemCount: 5,
            itemSize: 20.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              _selectedIcon ?? Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              // setState(() {
              //   getReqBooking.ratings = rating.toString();

              //   print(getReqBooking.ratings);
              //   print(widget.hotelData!.booking_schedule[0].booking_id);
              // });
            },
            updateOnDrag: true,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              // getReqBooking.rating(
              //     context, widget.hotelData!.booking_schedule[0].booking_id);
              Navigator.of(context).pop(true);
              // Navigator.pop(context);
            },
            child: Center(child: Text('ok')),
          ),
        ],
      ),
    );
  }

  getstutus(RequestedBooking? requestedBooking) {
    return widget.requestedBooking!.is_active != "1" &&
            widget.requestedBooking!.is_active != "0"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 35,
              ),
              // ignore: deprecated_member_use

              // ignore: deprecated_member_use
              RaisedButton.icon(
                onPressed: () {
                  setState(() {
                    getReqBooking.statuss = "1";
                    getReqBooking.updateStatus(
                        context, widget.requestedBooking!.id);
                  });
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: const Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                textColor: kPrimaryColor,
                splashColor: Colors.white,
                color: Colors.green,
              ),
              // ignore: deprecated_member_use
              RaisedButton.icon(
                onPressed: () {
                  setState(() {
                    getReqBooking.statuss = "0";
                    getReqBooking.updateStatus(
                        context, widget.requestedBooking!.id);
                  });
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: const Text(
                  'Reject',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                textColor: kPrimaryColor,
                splashColor: Colors.white,
                color: Colors.red,
              ),
              // ignore: deprecated_member_use

              const SizedBox(
                height: 35,
              ),
            ],
          )
        : Obx(() => getReqBooking.isfetchedsubject.value
            ? widget.requestedBooking!.ended_at == null
                ? AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _displayTextInputDialog(
                                    context, widget.requestedBooking!.id);
                              },
                              child: Container(
                                height: 35,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: DesignCourseAppTheme.nearlyBlue
                                            .withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 6.0),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'End Booking',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 35,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: DesignCourseAppTheme.nearlyBlue
                                          .withOpacity(0.5),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 6.0),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Booking ended at : ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          letterSpacing: 0.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        widget.requestedBooking!.ended_at,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          letterSpacing: 0.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
            : Center(
                child: Column(children: [
                CircularProgressIndicator(),
                // const Center(child: Text("No Booked Tutors"))
              ])));
  }
}
