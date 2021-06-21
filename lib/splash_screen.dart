import 'package:face_mask_detector/homepage.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 5,
      ),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: Image.asset(
              "assets/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Color.fromRGBO(
              255,
              255,
              255,
              0.4,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250,
                  height: 250,
                  child: rive.RiveAnimation.asset(
                    'assets/animate.riv',
                    animations: [
                      'Check_Int',
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  height: 4,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Face Mask Detector",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}