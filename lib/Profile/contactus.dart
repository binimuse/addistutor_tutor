import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/controller/contactuscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsView extends StatefulWidget {
  const ContactDetailsView({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

final ContactUSContolller contactUSContolller = Get.put(ContactUSContolller());

class _HomePageState extends State<ContactDetailsView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    contactUSContolller.getcontact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Material(
            color: Colors.white,
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
            "Contact us",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        body: Obx(() => contactUSContolller.isfetchedsubject.value
            ? ListView(
                children: [
                  Container(
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: Image.asset(
                        'assets/images/lg3.png',
                        height: 200,
                        width: 260,
                      ),
                    ),
                  ),
                  Center(
                      child: Text(contactUSContolller.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600))),
                  const Center(
                      child: Text('${"Addis Ababa"}, ${"Ethiopia"}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.normal))),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ListTile(
                            title: const Text(
                              'Phone number',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            subtitle: Text(
                              contactUSContolller.phone,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xf3333333)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.call,
                                    color: kPrimaryColor,
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const CircleBorder()),
                                ),
                              ],
                            )),
                        ListTile(
                            title: const Text(
                              'Phone number',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            subtitle: Text(
                              contactUSContolller.phone2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xf3333333)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.call,
                                    color: kPrimaryColor,
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const CircleBorder()),
                                ),
                              ],
                            )),
                        ListTile(
                            title: const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            subtitle: Text(
                              contactUSContolller.email,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xf3333333)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.email,
                                    color: kPrimaryColor,
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const CircleBorder()),
                                ),
                              ],
                            )),
                        ListTile(
                            title: const Text(
                              'Website',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            subtitle: const Text(
                              "https://nextgeneducation.et/",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.link,
                                    color: kPrimaryColor,
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const CircleBorder()),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Account Linked',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchURLfb(contactUSContolller.telegram);
                          },
                          child: ListTile(
                            title: const Text(
                              'Telegram',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            trailing: Image.asset('assets/images/telegram.png'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURLfb(contactUSContolller.facebook);
                          },
                          child: ListTile(
                            title: const Text(
                              'Facebook',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            trailing: Image.asset(
                              'assets/images/fb.jpg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURLfb(contactUSContolller.twitter);
                          },
                          child: ListTile(
                            title: const Text(
                              'Twitter',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            trailing: Image.asset(
                              'assets/images/tw.jpg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURLfb(contactUSContolller.instagram);
                          },
                          child: ListTile(
                            title: const Text(
                              'Instagram',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            trailing: Image.asset(
                              'assets/images/in.jpg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURLfb(contactUSContolller.linkedin);
                          },
                          child: ListTile(
                            title: const Text(
                              'LinkedIn',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                            trailing: Image.asset(
                              'assets/images/lin.jpg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator())));
  }

  _launchURLfb(String facebook) async {
    var url = facebook.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
