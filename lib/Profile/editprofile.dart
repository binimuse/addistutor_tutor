// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/getlevelcontroller.dart';
import 'package:addistutor_tutor/controller/getlocationcontroller.dart';
import 'package:addistutor_tutor/controller/getqualifaicationcontroller.dart';
import 'package:addistutor_tutor/controller/getsubcontroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  final GetLevelContoller getLevelContoller = Get.find();
  final GetSubect getSubect = Get.find();
  GetLocationController getLocationController = Get.find();
  Getqulificationcontroller getqulificationcontroller = Get.find();
  final ImagePicker _picker = ImagePicker();
  ImagePicker picker = ImagePicker();
  bool _autovalidate = false;
  DateTime currentDate = DateTime.now();
  bool showsubject = false;
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  var body;
  var id;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      body = json.decode(token);

      if (body["teacher_id"] != null) {
        editprofileController.fetchPf(int.parse(body["teacher_id"]));
        setState(() {
          id = int.parse(body["teacher_id"]);
        });
      } else {
        var noid = "noid";
        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();

    editprofileController.date = DateFormat.yMd().format(DateTime.now());

    _fetchUser();
    _getlocation();
    _getlevel();
    _getsub();
    _getqulafication();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      _getsub();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  List<GetLocation> location = [];
  _getlocation() async {
    getLocationController.fetchLocation();

    location = getLocationController.listlocation.value;
    if (location != null && location.isNotEmpty) {
      setState(() {
        getLocationController.location = location[0];
      });
    }
  }

  List<GetLevel> level = [];
  _getlevel() async {
    getLevelContoller.fetchLocation();

    level = getLevelContoller.listlocation.value;
    if (level != null && level.isNotEmpty) {
      setState(() {
        getLevelContoller.level = level[0];
      });
    }
  }

  List<Subjects> sub = [];

  _getsub() async {
    getSubect.fetchLocation(editprofileController.lid);
    sub = getSubect.listlocation.value;
    if (sub != null && sub.isNotEmpty) {
      setState(() {
        getSubect.subject = sub[0];
      });
    }
  }

  List<GetQulification> qualification = [];
  _getqulafication() async {
    getqulificationcontroller.fetchLocation();

    qualification = getqulificationcontroller.listlocation.value;
    if (qualification != null && qualification.isNotEmpty) {
      setState(() {
        getqulificationcontroller.qualification = qualification[0];
      });
    }
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => editprofileController.isFetched.value
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,

            //cheak pull_to_refresh
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: editprofileController.scaffoldKey,
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 1,
                leading: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
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
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ),
              body: Form(
                autovalidate: _autovalidate,
                key: editprofileController.EditProf,
                child: Container(
                  padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        id != null
                            ? Center(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showPicker(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: kPrimaryColor,
                                        child: _imageFileList != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.file(
                                                    File(_imageFileList![0]
                                                        .path),
                                                    width: 95,
                                                    height: 95,
                                                    fit: BoxFit.cover),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                width: 100,
                                                height: 100,
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                            color: kPrimaryColor,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              _showPicker(context);
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : Container(),
                        const Center(
                          child: Text(
                            "TUTOR INFORMATION",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'WorkSans',
                              letterSpacing: 0.27,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.firstname,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "First Name",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "your First  Name",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.middlename,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Middle Name",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "your Middle Name",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.lastname,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Last Name",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "your Last Name",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Gender',
                          style: TextStyle(color: kPrimaryColor, fontSize: 13),
                        ),
                        DropdownButtonFormField<String>(
                          value: editprofileController.macthgender.value,
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          items: <String>[
                            '',
                            'male',
                            'Female',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              editprofileController.macthgender.value = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Select BirthDate',
                          style: TextStyle(color: kPrimaryColor, fontSize: 13),
                        ),
                        OutlineButton(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(editprofileController.date.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Teaching since',
                          style: TextStyle(color: kPrimaryColor, fontSize: 13),
                        ),
                        DropdownButton<String>(
                          value: editprofileController.since.value,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          items: <String>[
                            '',
                            '2022',
                            '2021',
                            '2020',
                            '2019',
                            '2017',
                            '2016',
                            '2015',
                            '2014',
                            '2013',
                            '2012',
                            '2011',
                            '2010',
                            '2009',
                            '2008',
                            '2007',
                            '2006',
                            '2005',
                            '2004',
                            '2003',
                            '2002',
                            '2001',
                            '2000',
                            '1999',
                            '1998',
                            '1997',
                            '1996',
                            '1995',
                            '1994',
                            '1993',
                            '1992',
                            '1991',
                            '1990',
                            '1989',
                            '1988',
                            '1987',
                            '1986',
                            '1985',
                            '1984',
                            '1983',
                            '1982',
                            '1981',
                            '1980',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              editprofileController.since.value = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Highest Qualification',
                          style: TextStyle(color: kPrimaryColor, fontSize: 13),
                        ),
                        DropdownButton<GetQulification>(
                          hint: Text(
                            getqulificationcontroller.listlocation.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          items: qualification
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              getqulificationcontroller.qualification = value!;

                              editprofileController.qualifications =
                                  value.id.toString();
                            });

                            // pop current page
                          },
                          value: getqulificationcontroller.qualification,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "CONTACT INFORMATION",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'WorkSans',
                              letterSpacing: 0.27,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.email,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Email",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "evan@gmail.com",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateEmail(value!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.phone,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Phone",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "0911111111",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.officephone,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Office phone number",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "0911111111",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.rephone,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Residence Phone numbe",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "0911111111",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.subcity,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Subcity",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Subcity",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.woreda,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Woreda",
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Woreda",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "GUARANTOR CONTACT INFORMATION",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'WorkSans',
                              letterSpacing: 0.27,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.g_firstname,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Guarantor First name",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Guarantor First  Name",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.g_lastname,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Guarantor Last name",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Guarantor Last  Name",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.g_woreda,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Guarantor woreda",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Guarantor woreda",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.g_subcity,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Guarantor subcity",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Guarantor subcity",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.g_phone,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Guarantor mobile number",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Guarantor mobile number",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: editprofileController.g_office_phone,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Guarantor office phone number",
                              focusColor: kPrimaryColor,
                              labelStyle:
                                  TextStyle(color: kPrimaryColor, fontSize: 16),
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Guarantor recidence phone number",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "ENGAGMENT PREFERENCE",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'WorkSans',
                              letterSpacing: 0.27,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Preferred level for tutoring',
                          style: TextStyle(color: kPrimaryColor, fontSize: 13),
                        ),
                        DropdownButton<GetLevel>(
                          hint: Text(
                            getLevelContoller.listlocation.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          items: level
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              getLevelContoller.level = value!;
                              editprofileController.level = value.id.toString();
                              //   lid = value.id.toString();
                            });

                            //_onRefresh();
                            // loadData();
                            //  getSubect.fetchLocation(value!.id.toString());

                            // pop current page
                          },
                          value: getLevelContoller.level,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        subjectViewUI(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Prefered tutoring location',
                          style: TextStyle(color: kPrimaryColor, fontSize: 13),
                        ),
                        DropdownButton<GetLocation>(
                          hint: Text(
                            getLocationController.listlocation.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          items: location
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              getLocationController.location = value!;
                              editprofileController.locationid =
                                  value.id.toString();
                            });

                            // pop current page
                          },
                          value: getLocationController.location,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: editprofileController.About,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "About Me",
                                labelStyle: TextStyle(
                                    color: kPrimaryColor, fontSize: 16),
                                focusColor: kPrimaryColor,
                                fillColor: kPrimaryColor,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Describe yourself",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlineButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("CANCEL",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.black)),
                            ),
                            RaisedButton(
                              onPressed: () {
                                final isValid = editprofileController
                                    .EditProf.currentState!
                                    .validate();
                                if (isValid == true) {
                                  editprofileController.editProf(id, context);
                                } else {
                                  setState(() {
                                    _autovalidate =
                                        true; //enable realtime validation
                                  });
                                }
                              },
                              color: kPrimaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                "SAVE",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        editprofileController.date = DateFormat.yMd().format(currentDate);
      });
    }
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code
      //  _fetchUser();
      EasyLoading.dismiss();
    });
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: kPrimaryColor,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            focusColor: kPrimaryColor,
            fillColor: kPrimaryColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        _imageFile = pickedFile;
        var file = File(pickedFile!.path);

        editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        _imageFile = pickedFile;
        File file = File(pickedFile!.path);

        editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }

  subjectViewUI() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Field of study',
            style: TextStyle(color: kPrimaryColor, fontSize: 13),
          ),
          DropdownButton<Subjects>(
            hint: Text(
              getSubect.listlocation.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            items: sub
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                getSubect.subject = value!;
                editprofileController.fieldofstudy = value.id.toString();
              });

              // pop current page
            },
            value: getSubect.subject,
          ),
        ]);
  }
}
