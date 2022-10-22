// ignore_for_file: import_of_legacy_library_into_null_safe, unused_element, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, deprecated_member_use, duplicate_ignore

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Avalablity/avalabilty.dart';
import 'package:addistutor_tutor/Login/login_screen.dart';
import 'package:addistutor_tutor/Profile/contactus.dart';
import 'package:addistutor_tutor/Profile/getmyaccount.dart';
import 'package:addistutor_tutor/Profile/setting.dart';
import 'package:addistutor_tutor/Profile/termsodservice.dart';
import 'package:addistutor_tutor/Profile/updateprofile.dart';
import 'package:addistutor_tutor/Wallet/wallet.dart';
import 'package:addistutor_tutor/controller/avlablityconroller.dart';
import 'package:addistutor_tutor/controller/contactuscontroller.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/endbookingcontroller.dart';
import 'package:addistutor_tutor/controller/feedbackcontroller.dart';
import 'package:addistutor_tutor/controller/getlevelcontroller.dart';
import 'package:addistutor_tutor/controller/getlocationcontroller.dart';
import 'package:addistutor_tutor/controller/getmypernalityscontroller.dart';
import 'package:addistutor_tutor/controller/getnotificationcontoller.dart';
import 'package:addistutor_tutor/controller/getqualifaicationcontroller.dart';
import 'package:addistutor_tutor/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_tutor/controller/getsubcontroller.dart';
import 'package:addistutor_tutor/controller/removeaccountcontroller.dart';
import 'package:addistutor_tutor/controller/sendqrcodecontroller.dart';
import 'package:addistutor_tutor/controller/signupcontroller.dart';
import 'package:addistutor_tutor/controller/updateprofilecontroller.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'editprofile.dart';
import 'feedback_screen.dart';
import 'mypenality.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileS(),
    );
  }
}

bool _isLoggedIn = false;
GoogleSignIn _googleSignIn = GoogleSignIn();
final Avalablitycontrollerclass avalablitycontrollerclass =
    Get.put(Avalablitycontrollerclass());
final GetLevelContoller getLevelContoller = Get.put(GetLevelContoller());
final GetSubect getSubect = Get.put(GetSubect());

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

  GetLocationController getLocationController =
      Get.put(GetLocationController());

  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final Getqulificationcontroller getqulificationcontroller =
      Get.put(Getqulificationcontroller());

  final RemoveScreencontroller removeaccount =
      Get.put(RemoveScreencontroller());

  final GetmyAccount getmyAccount = Get.put(GetmyAccount());
  @override
  void initState() {
    super.initState();

    _fetchUser();
    _getlocation();
    _getmyaccount();

    // _cheakwallet();

    // _getlevel();
    // _getsub();
    // _getqulification();
  }

  List<GetLevel> level = [];
  _getlevel() async {
    getLevelContoller.fetchLocation();
  }

  List<GetQulification> qualification = [];
  _getqulification() async {
    getqulificationcontroller.fetchLocation();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      _getlocation();
      _fetchUser();
      _getmyaccount();
      // _cheakwallet();
    });
    _refreshController.refreshCompleted();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();

    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _refreshController.loadComplete();
  }

  var ids;

  _getlocation() async {
    getLocationController.fetchLocation();

    // location = getLocationController.listlocation.value;
    // if (location != null && location.isNotEmpty) {
    //   setState(() {
    //     getLocationController.getLocation = location[0];
    //     //   getLocationController.getLocation!.locaion = location[0];
    //     getLocationController.subcity = location[0];
    //   });
    // }
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        setState(() {
          ids = int.parse(body["teacher_id"]);
        });
        editprofileController.fetchPf(int.parse(body["teacher_id"]));
      } else {
        var noid = "noid";

        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return editprofileController.obx(
        (editForm) => WillPopScope(
              onWillPop: _onBackPressed,
              child: Scaffold(
                key: editprofileController.keyforall,
                backgroundColor: Colors.grey.shade100,
                extendBodyBehindAppBar: true,
                extendBody: true,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      editprofileController.keyforall.currentState!
                          .openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: kPrimaryLightColor,
                      size: 30,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                drawer: _buildDrawer(
                  context,
                  editprofileController.firstname.text.toString(),
                  editprofileController.middlename.text.toString(),
                  ids,
                ),
                body: SmartRefresher(
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
                              "https://nextgeneducation.et/api/teacher-profile-picture/${ids}"),
                          coverImage: const NetworkImage(
                              "https://nextgeneducation.et/lg3.png"),
                          title: editprofileController.firstname.text
                                  .toString() +
                              " " +
                              editprofileController.middlename.text.toString(),
                          actions: <Widget>[
                            MaterialButton(
                              color: Colors.white,
                              shape: const CircleBorder(),
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
                                            const UpdateProfile(),
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
                          gender: editprofileController.macthgender.value
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        onLoading: Center(child: loadData()),
        onEmpty: const Text("Can't fetch data"),
        onError: (error) => Center(child: Text(error.toString())));
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
        "https://nextgeneducation.et/api/teacher-profile-picture/${ids}";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary,
              boxShadow: const [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
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
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const UpdateProfile(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.update,
                      "Update profile",
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const FeedbackScreen(),
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
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const AvalablityScreen(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.event_available,
                      "Availability",
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const Mypernality(),
                          ),
                        );
                      },
                      child: _buildRow(
                          Icons.personal_injury_outlined, "Penalties")),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => WalletPage(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.money,
                      "Wallet",
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const SettingsFourPage(),
                          ),
                        );
                      },
                      child: _buildRow(Icons.settings, "Settings")),
                  _buildDivider(),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const ContactDetailsView(),
                          ),
                        );
                      },
                      child: _buildRow(Icons.email, "Contact us")),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const ProductDescriptionPage(),
                          ),
                        );
                      },
                      child: _buildRow(Icons.rule, "Terms of service")),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).removeCurrentSnackBar();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          elevation: 0,
                          backgroundColor: const Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Are you sure you want to remove this account?',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                          actions: <Widget>[
                            // ignore: deprecated_member_use
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: InkWell(
                                highlightColor: Colors.grey[200],
                                onTap: () async {
                                  SharedPreferences localStorage =
                                      await SharedPreferences.getInstance();
                                  var token = localStorage.getString('user');

                                  if (token != null) {
                                    var body = json.decode(token);

                                    if (body["id"] != null) {
                                      setState(() {
                                        ids = body["id"];
                                        removeaccount.seteditInfo(context, ids);
                                      });
                                    } else {
                                      var noid = "noid";
                                    }
                                  } else {}
                                },
                                child: const Center(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              height: 1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              child: InkWell(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                                highlightColor: Colors.grey[200],
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.person_remove_alt_1,
                      "Remove account",
                    ),
                  ),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () async {
                        Scaffold.of(context).removeCurrentSnackBar();

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 0,
                            backgroundColor: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Are you sure you want to log out?',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ]),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                child: InkWell(
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    });
                                    _logout(context);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const Divider(
                                height: 1,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                child: InkWell(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: _buildRow(Icons.logout, "Log out")),
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
    localStorage.remove('user');
    Get.delete<SignupController>();
    Get.delete<EditprofileController>();
    Get.delete<Avalablitycontrollerclass>();
    Get.delete<ContactUSContolller>();
    Get.delete<FeedBackScreencontroller>();
    Get.delete<WalletContoller>();
    Get.delete<SendQrcode>();
    Get.delete<GetReqBooking>();
    Get.delete<GetNotigicationController>();
    Get.delete<GetLevelContoller>();
    Get.delete<Updateprofilecontoller>();
    Get.delete<GetPenalitycontoller>();
    Get.delete<EndBookingContoller>();
    Get.delete<GetmyAccount>();

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const LoginScreen(),
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
        const SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        const Spacer(),
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
              child: const Text(
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
  final String? gender;

  final String? about;
  const UserInfo({
    Key? key,
    required this.phone,
    required this.email,
    required this.about,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: const Text(
              "Tutor information",
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
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            leading: const Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                            ),
                            title: const Text("Phone"),
                            subtitle: Text(phone.toString()),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.email, color: kPrimaryColor),
                            title: const Text("Email"),
                            subtitle: Text(email.toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.male_sharp,
                                color: kPrimaryColor),
                            title: const Text("Gender"),
                            subtitle: Text(gender.toString()),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            title: const Text("About Me"),
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
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>,
                fit: BoxFit.contain),
          ),
        ),
        Ink(
          height: 200,
          decoration: const BoxDecoration(
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
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
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
