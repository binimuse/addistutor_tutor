// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:addistutor_tutor/Wallet/topuppage.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:flutter/material.dart';

// ignore: library_prefixes

// ignore: library_prefixes

class PreviewImageScreengallery extends StatefulWidget {
  final String imagePath;

  // ignore: use_key_in_widget_constructors
  const PreviewImageScreengallery({required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreengallery> {
  File? imageFile;

  @override
  void initState() {
    super.initState();
    //getImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            }),
        title: const Text(
          "Preview",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
      ),
      body: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.file(File(widget.imagePath),
                  height: 550, fit: BoxFit.contain),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TopUpPage(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Confirm',
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
              ),
            )),
          ],
        ),
      ),
    );
  }
}
