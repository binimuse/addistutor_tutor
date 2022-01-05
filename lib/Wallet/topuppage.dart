import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../constants.dart';
import 'preview_screen_gallery.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

Future<File>? imageFile;

class _FeedbackScreenState extends State<TopUpPage> {
  ImagePicker picker = ImagePicker();

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
          body: SingleChildScrollView(
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
                  _buildComposerslip(),
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
    );
  }

  Widget _buildComposerslip() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
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
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
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
              constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
              color: AppTheme.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 0, bottom: 0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'File Upload',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.dark_grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                        selectImages();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: kPrimaryColor,
                    ),
                    title: const Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CameraCamera(
                                    onFile: (file) {
                                      Navigator.of(context).pop();
                                      _onCapturePressed(file);
                                    },
                                  )));
                      //   _imgFromCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onCapturePressed(File file) {
    String path;
    path = file.path;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewImageScreengallery(
          imagePath: path,
        ),
      ),
    );
  }

  ImagePicker picker2 = ImagePicker();
  List<XFile>? _imageFileList = [];
  var imagesList = <File>[];
  var index = 0;
  set imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
      if (_imageFileList!.length > 1) {
        for (var file in _imageFileList!) {
          File convertedFile = File(file.path);

          imagesList.add(convertedFile);
        }
      } else {
        for (var file in _imageFileList!) {
          File convertedFile = File(file.path);
          imagesList.add(convertedFile);

          index = imagesList.length - 1;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PreviewImageScreengallery(
                        imagePath: file.path,
                      )));
        }
      }
      selectedImages.clear();
      _imageFileList!.clear();
    }
  }
}
