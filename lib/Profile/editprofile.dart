/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */

import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
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
      body: Container(
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
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: kPrimaryColor,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", "Evan kutto", false),
              buildTextField("E-mail", "evan@gmail.com", false),
              buildTextField("Password", "********", true),
              buildTextField("Location", "New Joursey", false),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {},
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
    );
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
}
