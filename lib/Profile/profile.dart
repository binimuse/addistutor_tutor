import 'dart:convert';

import 'package:addistutor_tutor/Avalablity/avalabilty.dart';
import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/Notification/notification.dart';
import 'package:addistutor_tutor/Profile/setting.dart';
import 'package:addistutor_tutor/controller/avlablityconroller.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/signupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'editprofile.dart';
import 'feedback_screen.dart';
import 'help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileS(),
    );
  }
}

bool _isLoggedIn = false;
GoogleSignIn _googleSignIn = GoogleSignIn();
final Avalablitycontrollerclass avalablitycontrollerclass =
    Get.put(Avalablitycontrollerclass());

class ProfileS extends StatefulWidget {
  const ProfileS({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileS> {
  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  @override
  void initState() {
    super.initState();

    _fetchUser();
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

  var ids;

  void _fetchUser() async {
    if (editprofileController.isActive.toString() == "1") {
      avalablitycontrollerclass.isSelected = [true, false];
      print("avalble");
    } else {
      print("Not avalble");
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
        print("no Id");
        editprofileController.fetchPf(noid);
      }
    } else {
      print("no Token");
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: _buildDrawer(
        context,
        editprofileController.firstname.text.toString(),
        editprofileController.lastname.text.toString(),
        ids,
      ),
      body: editprofileController.obx(
          (editForm) => SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ProfileHeader(
                        avatar: NetworkImage(
                            "https://tutor.oddatech.com/api/teacher-profile-picture/${ids}"),
                        coverImage: NetworkImage(
                            "https://tutor.oddatech.com/api/teacher-profile-picture/${ids}"),
                        title: editprofileController.firstname.text.toString() +
                            " " +
                            editprofileController.lastname.text.toString(),
                        subtitle: "Tutor",
                        actions: <Widget>[
                          MaterialButton(
                            color: Colors.white,
                            shape: CircleBorder(),
                            elevation: 0,
                            child: const Icon(
                              Icons.edit,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                // ignore: prefer_const_constructors
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          EditPage(),
                                  transitionDuration: Duration.zero,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      UserInfo(
                        phone: editprofileController.phone.text.toString(),
                        email: editprofileController.email.text.toString(),
                        about: editprofileController.About.text.toString(),
                      ),
                    ],
                  ),
                ),
              ),
          onLoading: Center(child: loadData()),
          onEmpty: const Text("Can't fetch data"),
          onError: (error) => Center(child: Text(error.toString()))),
    );
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  _buildDrawer(BuildContext context, String fname, String lastname, ids) {
    final String image =
        "https://tutor.oddatech.com/api/teacher-profile-picture/${ids}";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [kPrimaryColor, kPrimaryColor])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    fname.toString() + " " + lastname.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              EditPage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.update,
                      "update profile",
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const FeedbackScreen(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.notifications,
                      "Give feedback",
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const AvalablityScreen(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.event_available,
                      "Avalablity",
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          // ignore: prefer_const_constructors
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                SettingsFourPage(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: _buildRow(Icons.settings, "Settings")),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          // ignore: prefer_const_constructors
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                HelpScreen(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: _buildRow(Icons.info_outline, "Help")),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 0,
                            backgroundColor: Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15),
                                  const Text(
                                    'Message',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Divider(
                                    height: 1,
                                    color: kPrimaryColor,
                                  ),
                                ]),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15),
                                  const Text(
                                    'Are You Sure you want to Log Out',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                ]),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: InkWell(
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                    _logout(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Divider(
                                height: 1,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: InkWell(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: _buildRow(Icons.logout, "Logout")),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Get.delete<SignupController>();
    Get.delete<EditprofileController>();

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginScreen(),
        transitionDuration: Duration.zero,
      ),
    );

    _googleSignIn.signOut().then((value) {
      setState(() {
        _isLoggedIn = false;
      });
    }).catchError((e) {});
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle =
        TextStyle(color: active, fontSize: 16.0, fontFamily: "WorkSans");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: kPrimaryColor,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: kPrimaryColor,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String? phone;
  final String? email;

  final String? about;
  const UserInfo({
    Key? key,
    required this.phone,
    required this.email,
    required this.about,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                            ),
                            title: Text("Phone"),
                            subtitle: Text(phone.toString()),
                          ),
                          ListTile(
                            leading: Icon(Icons.email, color: kPrimaryColor),
                            title: Text("Email"),
                            subtitle: Text(email.toString()),
                          ),
                          // ListTile(
                          //   leading: Icon(Icons.grade, color: kPrimaryColor),
                          //   title: Text("Birth Day"),
                          //   subtitle: Text(birthday.toString()),
                          // ),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            title: Text("About Me"),
                            subtitle: Text(about.toString()),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
      required this.coverImage,
      required this.avatar,
      required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: kPrimaryColor,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
      required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image as ImageProvider<Object>?,
        ),
      ),
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
