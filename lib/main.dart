import 'package:camera/camera.dart';
import 'package:face_mask_detector/splash_screen.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    MyApp(),
  );
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
