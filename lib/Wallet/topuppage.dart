import 'dart:convert';

import 'package:addistutor_tutor/Avalablity/avalabilty.dart';
import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../constants.dart';
import 'preview_screen_gallery.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

Future<File>? imageFile;
final ImagePicker _picker = ImagePicker();

class _FeedbackScreenState extends State<TopUpPage> {
  var body;
  var ids;

  @override
  void initState() {
    // TODO: implement initState
    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      body = json.decode(token);

      if (body["teacher_id"] != null) {
        ids = int.parse(body["teacher_id"]);

        print("yes");
      } else {
        var noid = "noid";
        //  editprofileController.fetchPf(noid);

        print("Nooo");
      }
    } else {
      print("cant");
    }
  }

  ImagePicker picker = ImagePicker();

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final WalletContoller walletContoller = Get.put(WalletContoller());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
              "Top Up",
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
            key: walletContoller.Formkey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          left: 16,
                          right: 16),
                      child: Image.asset('assets/images/feedbackImage.png'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 32, right: 32),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(4, 4),
                                blurRadius: 8),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            constraints: const BoxConstraints(
                                minHeight: 80, maxHeight: 160),
                            color: AppTheme.white,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0, bottom: 0),
                              child: TextFormField(
                                controller: walletContoller.slipid,
                                maxLines: null,
                                onChanged: (String txt) {},
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontSize: 16,
                                  color: AppTheme.dark_grey,
                                ),
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your Slip Id...'),
                                validator: (value) {
                                  return walletContoller.validateName(value!);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 32, right: 32),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(4, 4),
                                blurRadius: 8),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            constraints: const BoxConstraints(
                                minHeight: 80, maxHeight: 160),
                            color: AppTheme.white,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0, bottom: 0),
                              child: TextFormField(
                                controller: walletContoller.ammount,
                                maxLines: null,
                                onChanged: (String txt) {},
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontSize: 16,
                                  color: AppTheme.dark_grey,
                                ),
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your Ammount...'),
                                validator: (value) {
                                  return walletContoller.validateName(value!);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildComposer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: kPrimaryColor,
                            child: InkWell(
                              onTap: () {
                                walletContoller.editProf(context, ids);
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
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
                        borderRadius: BorderRadius.circular(40),
                        child: Image.file(File(_imageFileList![0].path),
                            width: 95, height: 95, fit: BoxFit.cover),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.file_upload_sharp,
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
                  width: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    color: Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child:
                        Text("Upload", style: TextStyle(color: kPrimaryColor)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: kPrimaryColor,
                      ),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: kPrimaryColor,
                    ),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
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

        walletContoller.image = file;
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

        walletContoller.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }
}
