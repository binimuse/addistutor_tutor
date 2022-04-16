// ignore_for_file: prefer_typing_uninitialized_variables, invalid_use_of_protected_member, unnecessary_null_comparison

import 'dart:async';

import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'design_course_app_theme.dart';

class SinglebookingPage extends StatefulWidget {
  const SinglebookingPage({Key? key, this.hotelData, this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final int? hotelData;

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

final GetReqBooking requestedBooking = Get.put(GetReqBooking());

class _CourseInfoScreenState extends State<SinglebookingPage>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  var isfetchedsubject5 = false.obs;

  late Timer timer;

  @override
  void initState() {
    _onRefresh();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();

    super.initState();
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

  var bid;

  _getsubject() {}

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      requestedBooking.getsingle(widget.hotelData);
    });

    // monitor network fetch
    //await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    if (mounted) {
      setState(() {});
    }

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if (mounted) {
      setState(() {
        _getsubject();
      });
    }

    _refreshController.loadComplete();
  }

  final Color divider = Colors.grey.shade600;
  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return Obx(() => requestedBooking.isfetchedsubject5.value
        ? Container(
            color: DesignCourseAppTheme.nearlyWhite,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Stack(
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
                                color:
                                    DesignCourseAppTheme.grey.withOpacity(0.2),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
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
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 32.0, left: 18, right: 16),
                                    child: Text(
                                      "Tutor info",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
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
                                        top: 32.0, left: 18, right: 16),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            requestedBooking.fname +
                                                " " +
                                                requestedBooking.mname,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              fontFamily: 'WorkSans',
                                              letterSpacing: 0.27,
                                              color: DesignCourseAppTheme
                                                  .darkerText,
                                            ),
                                          ),
                                          Text(
                                            requestedBooking.genders,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              fontFamily: 'WorkSans',
                                              letterSpacing: 0.27,
                                              color: DesignCourseAppTheme
                                                  .darkerText,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                requestedBooking.location,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans',
                                                  letterSpacing: 0.27,
                                                  color: DesignCourseAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.pin_drop,
                                                color: DesignCourseAppTheme
                                                    .nearlyBlue,
                                                size: 24,
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),

                                  // requestedBooking.about != null
                                  //     ? Expanded(
                                  //         child: AnimatedOpacity(
                                  //           duration: const Duration(milliseconds: 500),
                                  //           opacity: opacity2,
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 16, right: 16, bottom: 18),
                                  //             child: Center(
                                  //                 child: Text(
                                  //               widget.hotelData!.about,
                                  //               textAlign: TextAlign.justify,
                                  //               style: const TextStyle(
                                  //                 fontWeight: FontWeight.w300,
                                  //                 fontSize: 16,
                                  //                 fontFamily: 'WorkSans',
                                  //                 color: DesignCourseAppTheme.grey,
                                  //               ),
                                  //               maxLines: 10,
                                  //               overflow: TextOverflow.ellipsis,
                                  //             )),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : Expanded(
                                  //         child: AnimatedOpacity(
                                  //           duration: const Duration(milliseconds: 500),
                                  //           opacity: opacity2,
                                  //           child: const Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: 16, right: 16, bottom: 18),
                                  //             child: Center(
                                  //                 child: Text(
                                  //               "No About",
                                  //               textAlign: TextAlign.justify,
                                  //               style: TextStyle(
                                  //                 fontWeight: FontWeight.w300,
                                  //                 fontSize: 16,
                                  //                 fontFamily: 'WorkSans',
                                  //                 color: DesignCourseAppTheme.grey,
                                  //               ),
                                  //               maxLines: 10,
                                  //               overflow: TextOverflow.ellipsis,
                                  //             )),
                                  //           ),
                                  //         ),
                                  //       ),
                                  _buildDivider(),

                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, left: 18, right: 16),
                                    child: Text(
                                      "Booking info",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
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
                                          // getTimeBoxUI("location",
                                          //     requestedBooking.),
                                          getTimeBoxUI(1.toString(), 'Subject'),
                                          getTimeBoxUI(
                                              requestedBooking.session
                                                  .toString(),
                                              'Session'),
                                        ],
                                      ),
                                    ),
                                  ),

                                  getTimeBoxUI(requestedBooking.title, ''),
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, index) {
                                          return Column(
                                            children: [
                                              getTimeBoxUIday(requestedBooking
                                                  .reqdate[index].day
                                                  .toString()),
                                            ],
                                          );
                                        },
                                        itemCount:
                                            requestedBooking.reqdate.length),
                                  ),

                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).padding.bottom,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: (MediaQuery.of(context).size.width / 1.2) -
                            24.0 -
                            35,
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
                                    "https://nextgeneducation.et/api/teacher-profile-picture/${requestedBooking.tid}",
                                  )),
                            ))),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: SizedBox(
                        width: AppBar().preferredSize.height,
                        height: AppBar().preferredSize.height,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                AppBar().preferredSize.height),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: DesignCourseAppTheme.nearlyBlack,
                            ),
                            onTap: () {
                              Get.back();
                              // Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             super.widget));
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
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
                style: const TextStyle(
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
                style: const TextStyle(
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
}
