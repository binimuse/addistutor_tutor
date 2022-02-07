/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/controller/editprofilecontroller.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final ImagePicker _picker = ImagePicker();
  ImagePicker picker = ImagePicker();

  DateTime currentDate = DateTime.now();

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

        print("yes");
      } else {
        var noid = "noid";
        editprofileController.fetchPf(noid);

        print("Nooo");
      }
    } else {
      print("cant");
    }
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
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => editprofileController.isFetched.value
        ? Scaffold(
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
              key: editprofileController.EditProf,
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
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
                                                  File(_imageFileList![0].path),
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

                      // TextFormField(
                      //   controller: editprofileController.firstname,
                      //   decoration: const InputDecoration(
                      //       contentPadding: EdgeInsets.only(bottom: 3),
                      //       labelText: "First Name",
                      //       focusColor: kPrimaryColor,
                      //       fillColor: kPrimaryColor,
                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       hintText: "your First  Name",
                      //       hintStyle: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black,
                      //       )),
                      //   validator: (value) {
                      //     return editprofileController.validateName(value!);
                      //   },
                      // ),

                      // TextFormField(
                      //   controller: editprofileController.middlename,
                      //   decoration: const InputDecoration(
                      //       contentPadding: EdgeInsets.only(bottom: 3),
                      //       labelText: "Middle Name",
                      //       focusColor: kPrimaryColor,
                      //       fillColor: kPrimaryColor,
                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       hintText: "your Middle Name",
                      //       hintStyle: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black,
                      //       )),
                      //   validator: (value) {
                      //     return editprofileController.validateName(value!);
                      //   },
                      // ),
                      const SizedBox(
                        height: 35,
                      ),
                      // TextFormField(
                      //   controller: editprofileController.lastname,
                      //   decoration: const InputDecoration(
                      //       contentPadding: EdgeInsets.only(bottom: 3),
                      //       labelText: "Last Name",
                      //       focusColor: kPrimaryColor,
                      //       fillColor: kPrimaryColor,
                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       hintText: "your Last Name",
                      //       hintStyle: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black,
                      //       )),
                      //   validator: (value) {
                      //     return editprofileController.validateName(value!);
                      //   },
                      // ),
                      SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: editprofileController.email,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "Email",
                            focusColor: kPrimaryColor,
                            fillColor: kPrimaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "evan@gmail.com",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        validator: (value) {
                          return editprofileController.validateEmail(value!);
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: editprofileController.phone,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "Phone",
                            focusColor: kPrimaryColor,
                            fillColor: kPrimaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "0911111111",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        validator: (value) {
                          return editprofileController.validateName(value!);
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      // const Text(
                      //   'Select BirthDate',
                      //   style: TextStyle(color: Colors.black38),
                      // ),
                      // OutlineButton(
                      //   padding: EdgeInsets.symmetric(horizontal: 50),
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20)),
                      //   onPressed: () {
                      //     _selectDate(context);
                      //   },
                      //   child: Text(editprofileController.date.toString(),
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           letterSpacing: 2.2,
                      //           color: Colors.black)),
                      // ),
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextFormField(
                          controller: editprofileController.About,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "About Me",
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Describe yourself",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlineButton(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              print("bin");
                              print(id);
                              editprofileController.editProf(id, context);
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
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
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: kPrimaryColor,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            focusColor: kPrimaryColor,
            fillColor: kPrimaryColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
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
}
