import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool rearCameraSelected = false;

  void initCamera() {
    _controller = CameraController(
      cameras[rearCameraSelected ? 0 : 1],
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take Picture"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        children: [
          //Flip Camera Icon
          InkWell(
            onTap: () async {
              try {
                await _initializeControllerFuture;

                final image = await _controller.takePicture();

                if (!mounted) return;

                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      imagePath: image.path,
                    ),
                  ),
                );
              } catch (e) {
                rethrow;
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.black38,
                  size: 80,
                ),
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              rearCameraSelected = !rearCameraSelected;
              setState(() {
                initCamera();
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.black38,
                  size: 80,
                ),
                Icon(
                  rearCameraSelected
                      ? Icons.camera_front
                      : Icons.photo_camera_back,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
      floatingActionButton: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.black38,
                  size: 80,
                ),
                Icon(
                  Icons.check_box_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
