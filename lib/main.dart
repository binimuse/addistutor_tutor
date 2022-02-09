// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:addistutor_tutor/Profile/localstring.dart';
import 'package:addistutor_tutor/connectvity.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/splash/error.dart';
import 'package:addistutor_tutor/splash/splash_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Map _source = {ConnectivityResult.none: false};
MyConnectivity _connectivity = MyConnectivity.instance;
bool isconected = false;

class _MyHomePageState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          isconected = false;
        });

        // ignore: avoid_print

        break;
      case ConnectivityResult.mobile:
        setState(() {
          isconected = true;
        });
        // ignore: avoid_print

        break;
      case ConnectivityResult.wifi:
        setState(() {
          isconected = true;
        });

      // ignore: avoid_print

    }
    return isconected
        ? GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
            locale: const Locale('en', 'US'),
            title: 'Flutter Auth',
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: const SplashScreen(),
            builder: EasyLoading.init(),
          )
        : buildUnAuthScreen();
  }

  buildUnAuthScreen() {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      title: 'Flutter Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ConnectionFaildScreen(),
    );
  }
}
