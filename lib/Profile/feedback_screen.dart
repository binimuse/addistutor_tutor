import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/controller/feedbackcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'app_theme.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final FeedBackScreencontroller feedBackScreencontroller =
      Get.put(FeedBackScreencontroller());
  @override
  void initState() {
    super.initState();
    feedBackScreencontroller.isFetched(true);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => feedBackScreencontroller.isFetched.value
        ? Container(
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
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
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
                      "FeedBack",
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
                    key: feedBackScreencontroller.Formkey,
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
                              child: Image.asset(
                                  'assets/images/feedbackImage.png'),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8),
                              child: const Text(
                                'Your FeedBack',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 32, right: 32),
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
                                          left: 10,
                                          right: 10,
                                          top: 0,
                                          bottom: 0),
                                      child: TextFormField(
                                        controller:
                                            feedBackScreencontroller.feedback,
                                        decoration: const InputDecoration(
                                            fillColor: kPrimaryColor,
                                            border: InputBorder.none,
                                            hintText: 'Enter your feedback...'),
                                        style: const TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontSize: 16,
                                          color: AppTheme.dark_grey,
                                        ),
                                        cursorColor: Colors.blue,
                                        validator: (value) {
                                          return feedBackScreencontroller
                                              .validateName(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ignore: deprecated_member_use

                                // ignore: deprecated_member_use
                                RaisedButton(
                                  onPressed: () {
                                    feedBackScreencontroller.editProf(context);
                                  },
                                  color: kPrimaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    "Send",
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
                )))
        : const Center(child: CircularProgressIndicator()));
  }
}
