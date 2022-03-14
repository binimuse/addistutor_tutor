// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:addistutor_tutor/Welcome/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../constants.dart';

class MyPages extends StatelessWidget {
  const MyPages({Key? key}) : super(key: key);

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
  void _onIntroEnd(context) {
    Navigator.push(
      // ignore: prefer_const_constructors
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const WelcomeScreen(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return SvgPicture.asset(
      'assets/icons/$assetName',
      width: width,
      height: 250,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        fontSize: 25.0,
        fontFamily: 'Arial',
        fontWeight: FontWeight.bold,
        letterSpacing: 0.7,
        wordSpacing: 0.7,
        color: Colors.white);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontFamily: 'Roboto',
          letterSpacing: 0.4,
          fontWeight: FontWeight.w800,
          color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: kPrimaryColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: kPrimaryColor,

      pages: [
        PageViewModel(
          title: "CHOICE",
          body:
              "You can pick tutorials that work best for you based on time, level and location.",
          image: _buildImage('Choice.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Standardisation",
          body:
              "We will help standardise such things as time keeping, payments and professional ethics.",
          image: _buildImage('Safety.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "PROFESSIONAL DEVELOPMENT",
          body:
              "We will organize monthly professional development sessions to help you continue your own development as a teacher.",
          image: _buildImage('Convenience.svg'),
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
        activeColor: kPrimaryColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
