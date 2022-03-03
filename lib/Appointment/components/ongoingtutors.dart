// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_null_comparison

import 'dart:convert';

import 'package:addistutor_tutor/controller/getnotificationcontoller.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnGoingTutors extends StatefulWidget {
  const OnGoingTutors({
    Key? key,
    this.callBack,
  }) : super(key: key);

  final Function()? callBack;

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

var found;
GetNotigicationController getNotigicationController =
    Get.put(GetNotigicationController());

class _CategoryListViewState extends State<OnGoingTutors>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    setState(() {
      getNotigicationController.isfetchedlocation(true);
      _fetchUser();
    });

    super.initState();
  }

  var ids;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);
      setState(() {
        ids = int.parse(body["teacher_id"]);
      });

      //  getReqBooking.fetchReqBooking(body["student_id"]);
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => getNotigicationController.isfetchedlocation.value
        ? Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: SizedBox(
                height: 400,
                width: double.infinity,
                child: FutureBuilder(
                    future: RemoteServices.getrequestedbooking(ids, "1"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, right: 16, left: 16),
                          itemCount: snapshot.data.length,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = snapshot.data.length > 10
                                ? 10
                                : snapshot.data.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController?.forward();
                            return CategoryView(
                              category: snapshot.data[index],
                              animation: animation,
                              animationController: animationController,
                              callback: () {},
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'No Recommended Tutor found',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: 'WorkSans',
                            ),
                          ),
                        );
                      }
                    })),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}

GetNotigicationController getNotigicationController2 =
    Get.put(GetNotigicationController());

class CategoryView extends StatelessWidget {
  var kPrimaryColor;

  CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final RequestedBooking? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return Obx(() => getNotigicationController2.isfetchedlocation.value
        ? AnimatedBuilder(
            animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      100 * (1.0 - animation!.value), 0.0, 0.0),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 5.0, bottom: 5.0, right: 20.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Stack(
                              children: [
                                Container(
                                  width: 40,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                              "https://nextgeneducation.et/api/student-profile-picture/${category!.student.id}"))),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  category!.student.first_name +
                                      " " +
                                      category!.student.last_name,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  category!.student.gender,
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Row(children: [
                                    Row(children: [
                                      Icon(
                                        Icons.timer,
                                        color: kPrimaryColor,
                                        size: 10,
                                      ),
                                      Text(
                                        category!.session + " session",
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                                  ]),
                                ),
                                const SizedBox(height: 2),
                                Row(children: [
                                  Icon(
                                    Icons.subject,
                                    color: kPrimaryColor,
                                    size: 10,
                                  ),
                                  Text(
                                    category!.subject.title,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 2),
                                Row(children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: kPrimaryColor,
                                    size: 10,
                                  ),
                                  Text(
                                    category!.student.location.name,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 2),
                                Row(children: [
                                  Icon(
                                    Icons.phone,
                                    color: kPrimaryColor,
                                    size: 10,
                                  ),
                                  Text(
                                    category!.student.phone_no,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        ),
                        category!.is_active == null
                            ? Column(
                                children: <Widget>[
                                  Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "Pending",
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : category!.is_active != "0"
                                ? Column(
                                    children: <Widget>[
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "Accepted",
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.5),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: <Widget>[
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "Declied",
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.5),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(child: CircularProgressIndicator()));
  }
}
