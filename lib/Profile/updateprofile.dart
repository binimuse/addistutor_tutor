// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/controller/getlocationcontroller.dart';

import 'package:addistutor_tutor/controller/updateprofilecontroller.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'getmyaccount.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<UpdateProfile> {
  final Updateprofilecontoller updateprofilecontoller =
      Get.put(Updateprofilecontoller());
  GetLocationController getLocationController = Get.find();
  final ImagePicker _picker = ImagePicker();
  ImagePicker picker = ImagePicker();
  bool _autovalidate = false;
  DateTime currentDate = DateTime.now();
  bool showsubject = false;
  List<XFile>? _imageFileList;
  bool subc = false;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final GetmyAccount getmyAccount = Get.find();

  late var locationname = "";
  var body;
  var id;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      body = json.decode(token);

      if (body["teacher_id"] != null) {
        updateprofilecontoller.fetchPf(int.parse(body["teacher_id"]));
        setState(() {
          id = int.parse(body["teacher_id"]);
        });
      } else {
        var noid = "noid";
        updateprofilecontoller.fetchPf(noid);
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

    _fetchUser();
    _getlocation();
    _getmyaccount();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();
    setState(() {
      updateprofilecontoller.email.text = getmyAccount.email;
      updateprofilecontoller.phone.text = getmyAccount.phone;
    });
  }

  List<GetLocation> location = [];
  _getlocation() async {
    getLocationController.fetchLocation();

    location = getLocationController.listlocation.value;
    if (location != null && location.isNotEmpty) {
      setState(() {
        getLocationController.getLocation = location[0];
        //   getLocationController.getLocation!.locaion = location[0];
        getLocationController.subcity = location[0];
      });
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  List<Subjects> sub = [];

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => updateprofilecontoller.isFetched.value
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,

            //cheak pull_to_refresh
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: updateprofilecontoller.scaffoldKey,
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
                  "Update Profile",
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
                key: updateprofilecontoller.EditProf,
                child: Container(
                  padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: ListView(
                      children: [
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
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   controller: updateprofilecontoller.email,
                        //   decoration: const InputDecoration(
                        //     contentPadding: EdgeInsets.only(bottom: 3),
                        //     labelText: "Email",
                        //     labelStyle: TextStyle(
                        //       fontSize: 17,
                        //       fontWeight: FontWeight.w700,
                        //       color: kPrimaryColor,
                        //       fontFamily: 'WorkSans',
                        //     ),
                        //     focusColor: kPrimaryColor,
                        //     fillColor: kPrimaryColor,
                        //     hintText: "evan@gmail.com",
                        //     hintStyle: TextStyle(
                        //         color: DesignCourseAppTheme.nearlyBlack,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w300),
                        //   ),
                        //   validator: (value) {
                        //     return updateprofilecontoller.validateEmail(value!);
                        //   },
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: updateprofilecontoller.phone,
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
                                fontWeight: FontWeight.w300),
                          ),
                          validator: (value) {
                            return updateprofilecontoller.validateName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: updateprofilecontoller.officephone,
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
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: updateprofilecontoller.rephone,
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
                                fontWeight: FontWeight.w300),
                          ),
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
                        Row(children: [
                          Flexible(
                            child: DropdownButton<GetLocation>(
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
                                        child: Text(e.name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: DesignCourseAppTheme
                                                    .nearlyBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  getLocationController.subcity = value!;

                                  if (getLocationController
                                          .subcity!.locaion.length !=
                                      0) {
                                    subc = true;
                                  } else {
                                    subc = false;
                                  }
                                });

                                // pop current page
                              },
                              value: getLocationController.subcity,
                            ),
                          ),
                          subc
                              ? Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (_, index) {
                                        return Column(
                                          children: [
                                            getTimeBoxUIday(
                                                getLocationController.subcity!
                                                    .locaion[index].name,
                                                getLocationController
                                                    .getLocation!
                                                    .locaion[index]
                                                    .name),
                                          ],
                                        );
                                      },
                                      itemCount: getLocationController
                                          .subcity!.locaion.length),
                                )
                              : Container(),
                          Text(
                            locationname,
                            style: const TextStyle(color: Colors.black38),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: updateprofilecontoller.woreda,
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
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLength: 150,
                            textInputAction: TextInputAction.newline,
                            controller: updateprofilecontoller.About,
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
                              return updateprofilecontoller
                                  .validateNameaboutme(value!);
                            },
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
                                final isValid = updateprofilecontoller
                                    .EditProf.currentState!
                                    .validate();
                                if (isValid == true) {
                                  updateprofilecontoller.editProf(id, context);
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

  Widget getTimeBoxUIday(String txt2, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          updateprofilecontoller.subcityid = name.toString();
          locationname = txt2;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
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
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

        updateprofilecontoller.image = file;
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

        updateprofilecontoller.image = file;
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
        ]);
  }
}
