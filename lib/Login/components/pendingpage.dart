import 'package:addistutor_tutor/Profile/app_theme.dart';

import 'package:flutter/material.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({Key? key}) : super(key: key);

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
                leading: const Material(
                  color: Colors.white,
                ),
                title: const Center(
                  child: Text(
                    "Pending page",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'WorkSans',
                    ),
                  ),
                ),
              ),
              backgroundColor: AppTheme.nearlyWhite,
              body: Form(
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
                                child: const SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 0, bottom: 0),
                                  child: Text(
                                    'To Complete Your profile \nPlease go to NextGen Office ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.4,
                                      height: 0.9,
                                      color: Color(0xFF4A6572),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
