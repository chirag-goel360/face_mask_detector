import 'package:camera/camera.dart';
import 'package:face_mask_detector/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraImage cameraImage;
  CameraController cameraController;
  bool isWorking = false;
  String result = "";

  initializeCamera() {
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((image) {
          if (!isWorking) {
            isWorking = true;
            cameraImage = image;
            runModelOnFrame();
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  runModelOnFrame() async {
    if (cameraImage != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((planes) {
          return planes.bytes;
        }).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recognitions.forEach((response) {
        result += response["label"] + "\n";
      });
      setState(() {});
      isWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Padding(
            padding: EdgeInsets.only(
              top: 40,
            ),
            child: Center(
              child: Text(
                result,
                style: TextStyle(
                  backgroundColor: Colors.black54,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: size.width,
              height: size.height - 100,
              child: Container(
                height: size.height - 100,
                child: (!cameraController.value.isInitialized)
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(
                          cameraController,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
