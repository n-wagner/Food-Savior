import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraTest extends StatefulWidget {
  @override
  _CameraTestState createState() => _CameraTestState();
}

class _CameraTestState extends State<CameraTest> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  var imagePath;
  
  @override
  void initState() {
    super.initState();
    _initializeCamera(); 
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera,ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  //@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _controller != null) {
      _initializeControllerFuture = _controller.initialize(); //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  void onCaptureButtonPressed() async {  //on camera button press
    try {

      final path = join(
        (await getTemporaryDirectory()).path, //Temporary path
        '${DateTime.now()}.png',
        );
      print(path);
      imagePath = path;
      await _controller.takePicture(path); //take photo

      setState(() {
        showCapturedPhoto = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Transform.scale(
                  scale: _controller.value.aspectRatio / deviceRatio,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller), //cameraPreview
                    ),
                  ));
            } else {
              return Center(
                  child:
                      CircularProgressIndicator()); // Otherwise, display a loading indicator.
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onCaptureButtonPressed();
        }
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }
}