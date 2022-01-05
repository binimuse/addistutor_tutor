import 'package:flutter/material.dart';

class ConnectionFaildScreen extends StatefulWidget {
  const ConnectionFaildScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ConnectionFaildScreen> {
  bool load = false;

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/err.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 13),
                    blurRadius: 25,
                    color: const Color(0xFF5666C2).withOpacity(0.17),
                  ),
                ],
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  "retry".toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
