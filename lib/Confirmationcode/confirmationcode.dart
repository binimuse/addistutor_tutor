import 'dart:io';

import 'package:addistutor_tutor/Home/components/homescreen.dart';
import 'package:addistutor_tutor/Profile/app_theme.dart';
import 'package:addistutor_tutor/controller/sendqrcodecontroller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constants.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
Barcode? result;
QRViewController? controller;

class _FeedbackScreenState extends State<CodeScreen> {
  SendQrcode sendQrcode = Get.put(SendQrcode());

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  bool ispresed = false;

  @override
  void initState() {
    if (result != null) {
      result = null;
    }
    super.initState();
  }

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
                  ispresed
                      ? Expanded(
                          flex: 2,
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        )
                      : Container(),
                  ispresed
                      ? Expanded(
                          flex: 1,
                          child: Center(
                            child: (result != null)
                                ? Column(children: [
                                    Text(
                                        'Sucessfully Scaned Qr code: ${result!.code}'),
                                    Material(
                                      color: kPrimaryColor,
                                      child: InkWell(
                                        onTap: () {
                                          //  snackBar();
                                          print(result!.code);
                                          setState(() {
                                            sendQrcode.qrcode = result!.code!;
                                            sendQrcode.qr(context);
                                          });
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
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
                                  ])
                                : Text('Canot find Qr Code'),
                          ))
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      // ignore: deprecated_member_use

                      RaisedButton.icon(
                        onPressed: () {
                          setState(() {
                            ispresed = true;
                          });
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        label: const Text(
                          'Scan Qr Code',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        ),
                        textColor: kPrimaryColor,
                        splashColor: Colors.white,
                        color: kPrimaryColor,
                      ),

                      // ignore: deprecated_member_use

                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  snackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sucessfully  Scaned Qr code"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}
