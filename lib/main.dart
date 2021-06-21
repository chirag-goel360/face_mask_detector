import 'package:face_mask_detector/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Mask Detector',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
