// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, deprecated_member_use, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_null_comparison

import 'dart:convert';

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/getmyaccount.dart';
import 'package:addistutor_tutor/components/form_drop_down_widget.dart';
import 'package:addistutor_tutor/components/form_drop_down_widget_cat.dart';
import 'package:addistutor_tutor/components/form_drop_down_widget_level.dart';
import 'package:addistutor_tutor/components/form_drop_down_widget_qul.dart';
import 'package:addistutor_tutor/components/form_drop_down_widget_sub.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:addistutor_tutor/controller/getcategorycontroller.dart';
import 'package:addistutor_tutor/controller/getlevelcontroller.dart';
import 'package:addistutor_tutor/controller/getlocationcontroller.dart';
import 'package:addistutor_tutor/controller/getqualifaicationcontroller.dart';
import 'package:addistutor_tutor/controller/getsubcontroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  final GetmyAccount getmyAccount = Get.put(GetmyAccount());

  final GetLevelContoller getLevelContoller = Get.find();
  final GetSubect getSubect = Get.find();
  final GetCatgroryContoller getCatgrory = Get.find();
  GetLocationController getLocationController = Get.find();
  Getqulificationcontroller getqulificationcontroller = Get.find();
  ImagePicker picker = ImagePicker();
  DateTime currentDate = DateTime.now();
  bool showsubject = false;
  bool e_showsubject = false;
  bool g_showsubject = false;
  bool realsubject = false;
  bool subc = false;
  bool g_subc = false;
  late var locationname = "";
  late var lid = "";
  late var glocationname = "";
  late var elocationname = "";
  late var plocationname = "";
  var showSubject = true.obs;

  var body;
  var ids;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      body = json.decode(token);

      if (body["teacher_id"] != null) {
        editprofileController.fetchPf(int.parse(body["teacher_id"]));
        setState(() {
          ids = int.parse(body["teacher_id"]);
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
    _getEmCategory();

    _getqulafication();
    _getmyaccount();
  }

  _getEmCategory() async {
    getCatgrory.fetchLocation();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();
    setState(() {
      editprofileController.email.text = getmyAccount.email;
      editprofileController.phone.text = getmyAccount.phone;
      editprofileController.firstname.text = getmyAccount.full_name;
    });
  }

  _getlocation() async {
    getLocationController.fetchLocation();
  }

  List<GetLevel> level = [];
  _getlevel() async {
    getLevelContoller.fetchLocation();
  }

  List<Subjects> sub = [];
  List<Subjects2> sub2 = [];

  _getsub() async {
    getSubect.fetchLocation(editprofileController.lid);
    // getSubect.fetchLocation2();
  }

  List<GetQulification> qualification = [];
  _getqulafication() async {
    getqulificationcontroller.fetchLocation();
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => editprofileController.isFetched.value
        ? Scaffold(
            resizeToAvoidBottomInset: true,
            key: editprofileController.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
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
              autovalidateMode: AutovalidateMode.disabled,
              key: editprofileController.EditProf,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),

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
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                        focusColor: kPrimaryColor,
                        fillColor: kPrimaryColor,
                        hintText: "Your name",
                        hintStyle: TextStyle(
                            color: DesignCourseAppTheme.nearlyBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
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
                        labelText: "Father's name",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                        focusColor: kPrimaryColor,
                        fillColor: kPrimaryColor,
                        hintText: "Your father's name",
                        hintStyle: TextStyle(
                            color: DesignCourseAppTheme.nearlyBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
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
                        labelText: "Grandfather's name",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                        focusColor: kPrimaryColor,
                        fillColor: kPrimaryColor,
                        hintText: "Grandfather's name",
                        hintStyle: TextStyle(
                            color: DesignCourseAppTheme.nearlyBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      validator: (value) {
                        return editprofileController.validateName(value!);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
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
                        'Male',
                        'Female',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: DesignCourseAppTheme.nearlyBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          editprofileController.macthgender.value = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Select date Of birth',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
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

                    // DropdownButton<GetQulification>(
                    //   hint: Text(
                    //     getqulificationcontroller.listlocation.toString(),
                    //     style: const TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    //   isExpanded: true,
                    //   style: const TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w700),
                    //   items: qualification
                    //       .map((e) => DropdownMenuItem(
                    //             child: Text(
                    //               e.title,
                    //               textAlign: TextAlign.left,
                    //               style: const TextStyle(
                    //                   color:
                    //                       DesignCourseAppTheme.nearlyBlack,
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w300),
                    //             ),
                    //             value: e,
                    //           ))
                    //       .toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       FocusScope.of(context)
                    //           .requestFocus(new FocusNode());
                    //       getqulificationcontroller.qualification = value!;

                    //       editprofileController.qualifications =
                    //           value.id.toString();
                    //     });

                    //     // pop current page
                    //   },
                    //   value: getqulificationcontroller.qualification,
                    // ),
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
                      readOnly: true,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          focusColor: kPrimaryColor,
                          fillColor: kPrimaryColor,
                          hintText: "evan@gmail.com",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
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
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          focusColor: kPrimaryColor,
                          fillColor: kPrimaryColor,
                          hintText: "0911111111",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
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
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          focusColor: kPrimaryColor,
                          fillColor: kPrimaryColor,
                          hintText: "0911111111",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
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
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          focusColor: kPrimaryColor,
                          fillColor: kPrimaryColor,
                          hintText: "0911111111",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Subcity',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                    FormDropDownWidget(
                      hintText: "Select Subcity".trArgs(),
                      options: getLocationController.listlocation.value,
                      value: getLocationController.listlocationvalue.value,
                      onChanged: (GetLocation subcitymodel) {
                        getLocationController.setLocationStatus(subcitymodel);
                      },
                    ),
                    // Row(children: [
                    //   Flexible(
                    //     child: DropdownButton<GetLocation>(
                    //       hint: Text(
                    //         getLocationController.listlocation.toString(),
                    //         style: const TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w400),
                    //       ),
                    //       isExpanded: true,
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w700),
                    //       items: location
                    //           .map((e) => DropdownMenuItem(
                    //                 child: Text(e.name,
                    //                     textAlign: TextAlign.left,
                    //                     style: const TextStyle(
                    //                         color: DesignCourseAppTheme
                    //                             .nearlyBlack,
                    //                         fontSize: 16,
                    //                         fontWeight: FontWeight.w300)),
                    //                 value: e,
                    //               ))
                    //           .toList(),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           FocusScope.of(context)
                    //               .requestFocus(new FocusNode());
                    //           getLocationController.subcity = value!;
                    //           editprofileController.subcityid =
                    //               value.name.toString();

                    //           if (getLocationController
                    //                   .subcity!.locaion.length !=
                    //               0) {
                    //             subc = true;
                    //           } else {
                    //             subc = false;
                    //           }
                    //         });

                    //         // pop current page
                    //       },
                    //       value: getLocationController.subcity,
                    //     ),
                    //   ),
                    //   Text(
                    //     locationname,
                    //     style: const TextStyle(color: Colors.black38),
                    //   ),
                    // ]),
                    // subc
                    //     ? SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: SizedBox(
                    //           height: 70,
                    //           child: ListView.builder(
                    //               shrinkWrap: true,
                    //               scrollDirection: Axis.horizontal,
                    //               itemBuilder: (_, index) {
                    //                 return Column(
                    //                   children: [
                    //                     getTimeBoxUIday(
                    //                         getLocationController.subcity!
                    //                             .locaion[index].name,
                    //                         getLocationController
                    //                             .getLocation!
                    //                             .locaion[index]
                    //                             .name),
                    //                   ],
                    //                 );
                    //               },
                    //               itemCount: getLocationController
                    //                   .subcity!.locaion.length),
                    //         ),
                    //       )
                    //     : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editprofileController.woreda,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Woreda",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          focusColor: kPrimaryColor,
                          fillColor: kPrimaryColor,
                          hintText: "Woreda",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "GUARANTOR'S CONTACT INFORMATION",
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
                          labelText: "Guarantor's first name",
                          focusColor: kPrimaryColor,
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          fillColor: kPrimaryColor,
                          hintText: "Insert guarantor's first name",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editprofileController.g_lastname,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Guarantor's father's name",
                          focusColor: kPrimaryColor,
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          fillColor: kPrimaryColor,
                          hintText: "Insert guarantor's father's name",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editprofileController.g_woreda,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Guarantor's woreda",
                          focusColor: kPrimaryColor,
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          fillColor: kPrimaryColor,
                          hintText: "Insert guarantor's woreda",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Guarantor's subcity",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),

                    FormDropDownWidget(
                      hintText: "Select Subcity".trArgs(),
                      options: getLocationController.listlocation.value,
                      value: getLocationController.listlocationvalue_gu.value,
                      onChanged: (GetLocation subcitymodel) {
                        getLocationController.setLocationStatusgu(subcitymodel);
                      },
                    ),
                    // Row(children: [
                    //   Flexible(
                    //     child: DropdownButton<GetLocation>(
                    //       hint: Text(
                    //         getLocationController.listlocation.toString(),
                    //         style: const TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w400),
                    //       ),
                    //       isExpanded: true,
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w700),
                    //       items: location
                    //           .map((e) => DropdownMenuItem(
                    //                 child: Text(e.name,
                    //                     textAlign: TextAlign.left,
                    //                     style: const TextStyle(
                    //                         color: DesignCourseAppTheme
                    //                             .nearlyBlack,
                    //                         fontSize: 16,
                    //                         fontWeight: FontWeight.w300)),
                    //                 value: e,
                    //               ))
                    //           .toList(),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           FocusScope.of(context)
                    //               .requestFocus(new FocusNode());
                    //           getLocationController.g_subcity = value!;
                    //           editprofileController.g_subcityid =
                    //               value.name.toString();

                    //           if (getLocationController
                    //                   .g_subcity!.locaion.length !=
                    //               0) {
                    //             g_subc = true;
                    //           } else {
                    //             g_subc = false;
                    //           }
                    //         });

                    //         // pop current page
                    //       },
                    //       value: getLocationController.g_subcity,
                    //     ),
                    //   ),
                    //   Text(
                    //     glocationname,
                    //     style: const TextStyle(color: Colors.black38),
                    //   ),
                    // ]),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editprofileController.g_phone,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Guarantor's mobile number",
                          focusColor: kPrimaryColor,
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          fillColor: kPrimaryColor,
                          hintText: "Insert guarantor's mobile number",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editprofileController.g_office_phone,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Guarantor's office phone number",
                          focusColor: kPrimaryColor,
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          fillColor: kPrimaryColor,
                          hintText: "Insert guarantor's office phone number",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "EMPLOYMENT INFORMATION",
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
                      'Employment Category',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                    FormDropDownWidgetCat(
                      hintText: "Select Category".trArgs(),
                      options: getCatgrory.listCategory.value,
                      value: getCatgrory.listlistCategoryvalue.value,
                      onChanged: (GetCategory subcitymodel) {
                        getCatgrory.setSubectStatus(subcitymodel);
                        print(subcitymodel.name);
                        if (subcitymodel.name == "Other Professionals") {
                          setState(() {
                            showSubject(false);
                          });
                        } else {
                          setState(() {
                            showSubject(true);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    showSubject.isTrue
                        ? TextFormField(
                            controller: editprofileController.e_firstname,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Employer name",
                                focusColor: kPrimaryColor,
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                  fontFamily: 'WorkSans',
                                ),
                                fillColor: kPrimaryColor,
                                hintText: "Insert  employer name",
                                hintStyle: TextStyle(
                                    color: DesignCourseAppTheme.nearlyBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    showSubject.isTrue
                        ? TextFormField(
                            controller: editprofileController.e_postion,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Employment position",
                                focusColor: kPrimaryColor,
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                  fontFamily: 'WorkSans',
                                ),
                                fillColor: kPrimaryColor,
                                hintText: "Employment position",
                                hintStyle: TextStyle(
                                    color: DesignCourseAppTheme.nearlyBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                          )
                        : SizedBox(),
                    showSubject.isTrue
                        ? const SizedBox(
                            height: 20,
                          )
                        : SizedBox(),

                    showSubject.isTrue
                        ? const Text(
                            'Employer subcity',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontFamily: 'WorkSans',
                            ),
                          )
                        : SizedBox(),
                    showSubject.isTrue
                        ? FormDropDownWidget(
                            hintText: "Select Subcity".trArgs(),
                            options: getLocationController.listlocation.value,
                            value:
                                getLocationController.listlocationvalue_e.value,
                            onChanged: (GetLocation subcitymodel) {
                              getLocationController
                                  .setLocationStatuse(subcitymodel);
                            },
                          )
                        : SizedBox(),

                    showSubject.isTrue
                        ? const SizedBox(
                            height: 20,
                          )
                        : SizedBox(),

                    showSubject.isTrue
                        ? TextFormField(
                            controller: editprofileController.e_woreda,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Employer woreda",
                                focusColor: kPrimaryColor,
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                  fontFamily: 'WorkSans',
                                ),
                                fillColor: kPrimaryColor,
                                hintText: "Insert employer woreda",
                                hintStyle: TextStyle(
                                    color: DesignCourseAppTheme.nearlyBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                          )
                        : SizedBox(),
                    showSubject.isTrue
                        ? const SizedBox(
                            height: 20,
                          )
                        : SizedBox(),

                    showSubject.isTrue
                        ? const Text(
                            'Teaching since',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontFamily: 'WorkSans',
                            ),
                          )
                        : SizedBox(),
                    showSubject.isTrue
                        ? DropdownButton<String>(
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
                              '2018',
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
                                      color: DesignCourseAppTheme.nearlyBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                editprofileController.since.value = value!;
                              });
                            },
                          )
                        : SizedBox(),
                    const Text(
                      'Highest qualification',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FormDropDownWidgetQul(
                      hintText: "Select qualification".trArgs(),
                      options: getqulificationcontroller.listQulification.value,
                      value:
                          getqulificationcontroller.listQulificationvalue.value,
                      onChanged: (GetQulification subcitymodel) {
                        getqulificationcontroller.setLevelStatus(subcitymodel);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    showSubject.isTrue
                        ? const Text(
                            'Subject you teach',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontFamily: 'WorkSans',
                            ),
                          )
                        : const SizedBox(),

                    showSubject.isTrue
                        ? FormDropDownWidgetSub(
                            hintText: "Select Subject".trArgs(),
                            options: getSubect.listSubject.value,
                            value: getSubect.listSubjectvalue_e.value,
                            onChanged: (Subjects subcitymodel) {
                              getSubect.setSubectStatus_e(subcitymodel);
                            },
                          )
                        : const SizedBox(),

                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "ENGAGEMENT PREFERENCE",
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    showSubject.isTrue
                        ? FormDropDownWidgetLevel(
                            hintText: "Preferred level for tutoring".trArgs(),
                            options: getLevelContoller.listlevel.value,
                            value: getLevelContoller.listlevelvalue.value,
                            onChanged: (GetLevel subcitymodel) {
                              getLevelContoller.setLevelStatus(subcitymodel);

                              editprofileController.lid = subcitymodel.id;
                              _getsub();
                            },
                          )
                        : const Text(
                            'Primary',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: 'WorkSans',
                            ),
                          ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Field of study',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                    getSubect.listSubject.value.isNotEmpty
                        ? FormDropDownWidgetSub(
                            hintText: "Select Subject".trArgs(),
                            options: getSubect.listSubject.value,
                            value: getSubect.listSubjectvalue.value,
                            onChanged: (Subjects subcitymodel) {
                              getSubect.setSubectStatus(subcitymodel);
                            },
                          )
                        : const Center(child: CircularProgressIndicator()),

                    // subjectViewUI(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Preferred tutoring location',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'WorkSans',
                      ),
                    ),

                    FormDropDownWidget(
                      hintText: "Select location".trArgs(),
                      options: getLocationController.listlocation.value,
                      value: getLocationController
                          .listlocationvalue_location.value,
                      onChanged: (GetLocation subcitymodel) {
                        getLocationController
                            .setLocationStatuslocation(subcitymodel);

                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());

                          if (getLocationController.listlocation.isNotEmpty) {
                            showsubject = true;
                          } else {
                            showsubject = false;
                          }
                        });
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLength: 250,
                        controller: editprofileController.About,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "About Me",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                            fontFamily: 'WorkSans',
                          ),
                          focusColor: kPrimaryColor,
                          fillColor: kPrimaryColor,
                          hintText: "Describe yourself",
                          hintStyle: TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        validator: (value) {
                          return editprofileController
                              .validateNameaboutme(value!);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            editprofileController.editProf(ids, context);
                          },
                          color: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
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
          )
        : const Center(child: CircularProgressIndicator()));
  }

  Widget getTimeBoxUIdaysub(
    String txt2,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          editprofileController.lid = txt2.toString();
          // locationname = txt2;
        });
      },
      child: Padding(
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
      ),
    );
  }

  Widget getTimeBoxUIday(String txt2, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          editprofileController.subcityid = name.toString();

          locationname = txt2;
        });
      },
      child: Padding(
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
      ),
    );
  }

  Widget getTimeBoxUIdayg(String txt2, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          editprofileController.g_subcityid = name.toString();

          glocationname = txt2;
        });
      },
      child: Padding(
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
      ),
    );
  }

  Widget getTimeBoxUIdaye(String txt2, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          editprofileController.e_subcityid = name.toString();
          elocationname = txt2;
        });
      },
      child: Padding(
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
      ),
    );
  }

  Widget getTimeBoxUIdaysu(
    String txt2,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // editprofileController.locationid = name.toString();
          plocationname = txt2;
        });
      },
      child: Padding(
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
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: currentDate);
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        editprofileController.date = DateFormat.yMd().format(currentDate);
      });
    }
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
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  // subjectViewUI() {
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         const Text(
  //           'Field of study',
  //           style: TextStyle(
  //             fontSize: 17,
  //             fontWeight: FontWeight.w700,
  //             color: kPrimaryColor,
  //             fontFamily: 'WorkSans',
  //           ),
  //         ),
  //         DropdownButton<Subjects>(
  //           hint: Text(
  //             getSubect.listlocation.toString(),
  //             style: const TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w400),
  //           ),
  //           isExpanded: true,
  //           style: const TextStyle(
  //               color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
  //           items: sub
  //               .map((e) => DropdownMenuItem(
  //                     child: Text(e.title,
  //                         textAlign: TextAlign.left,
  //                         style: const TextStyle(
  //                             color: DesignCourseAppTheme.nearlyBlack,
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w300)),
  //                     value: e,
  //                   ))
  //               .toList(),
  //           onChanged: (value) {
  //             setState(() {
  //               FocusScope.of(context).requestFocus(new FocusNode());
  //               getSubect.subject = value!;
  //               editprofileController.subjectid = value.id.toString();
  //             });

  //             // pop current page
  //           },
  //           value: getSubect.subject,
  //         ),
  //       ]);
  // }
}

class FollowedList extends StatefulWidget {
  final Subjects? subjects;

  const FollowedList({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  @override
  _SettingsScreenState2 createState() => _SettingsScreenState2();
}

final GetSubect getSubect = Get.find();

class _SettingsScreenState2 extends State<FollowedList> {
  @override
  void initState() {
    if (widget.subjects! != null) {
      // getSubect. .add(widget.day!.day);
      // values.clear();
    } else {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container());
  }
}
