// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:introduction_screen/introduction_screen.dart';

import '../constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return const Scaffold(
      body: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return SvgPicture.asset('assets/icons/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
      letterSpacing: 0.4,
      height: 0.9,
      color: Color(0xFF4A6572),
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Roboto',
          letterSpacing: 0.4,
          fontWeight: FontWeight.w800,
          color: kPrimaryColor),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "Register Request",
          body: "Complete all the fields in the registration page.",
          image: _buildImage('login.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tutor Selection",
          body:
              "The system will generate choices of tutor for you and you indicate your first and second choices.",
          image: _buildImage('chat.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tutor Contact",
          body: "The selected tutor contacts you and finalizes a mangement.",
          image: _buildImage('signup.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Unique Student Code",
          body:
              "You will receive a unique code which you will use to confirm service is successfully delivered.",
          image: _buildImage('signup.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Review Tutor",
          body:
              "After the service, you can rate the service the tutor provided.",
          image: _buildImage('signup.svg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
