import 'dart:io';

import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
// Barcode? result;
// QRViewController? controller;

class _FeedbackScreenState extends State<CodeScreen> {
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Confirmation code",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'WorkSans',
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  // Expanded(
                  //   flex: 5,
                  //   child: QRView(
                  //     key: qrKey,
                  //     onQRViewCreated: _onQRViewCreated,
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Enter  Code here',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

  Widget _buildComposer() {
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
                    hintText: 'Enter your feedback...'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
}
