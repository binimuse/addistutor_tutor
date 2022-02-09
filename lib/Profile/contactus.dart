import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/controller/contactuscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            "Contact US",
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
                              'Mobile',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
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
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
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
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            subtitle: const Text(
                              "https://nextgeneducation.et/",
                              style: TextStyle(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            'Telegram',
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Image.asset('assets/images/telegram.png'),
                        ),
                        ListTile(
                          title: const Text(
                            'WhatsApp',
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Image.asset('assets/images/whatsapp.png'),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator())));
  }
}
