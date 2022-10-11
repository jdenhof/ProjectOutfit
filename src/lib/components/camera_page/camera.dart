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
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;

  void _newCameraSelected(CameraDescription camera) async {
    final prevCameraController = _cameraController;

    final CameraController newCameraController = CameraController(
      camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await prevCameraController?.dispose();

    if (mounted) {
      setState(() {
        _cameraController = newCameraController;
      });
    }

    newCameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await newCameraController.initialize();
    } on CameraException catch (e) {
      throw ('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = _cameraController!.value.isInitialized;
      });
    }
  }

  void _flipCamera() {}

  void _takePicture() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _newCameraSelected(cameraController.description);
    }
  }

  @override
  void initState() {
    _isRearCameraSelected = true;
    _newCameraSelected(cameras[_isRearCameraSelected ? 0 : 1]);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Container(
              child: AspectRatio(
              aspectRatio: 1 / _cameraController!.value.aspectRatio,
              child: _cameraController!.buildPreview(),
            ))
          : Container(),
      floatingActionButton: Row(
        children: [
          //Flip Camera Icon
          InkWell(
            onTap: () {
              setState(() {
                _isCameraInitialized = false;
              });
              _newCameraSelected(
                cameras[_isRearCameraSelected ? 1 : 0],
              );
              setState(() {
                _isRearCameraSelected = !_isRearCameraSelected;
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
                  _isRearCameraSelected
                      ? Icons.camera_front
                      : Icons.camera_rear,
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
