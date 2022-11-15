import 'package:camera/camera.dart';

class CameraService {
  CameraService._();

  late List<CameraDescription> cameras;
  initializeCameras() async {
    cameras = await availableCameras();
  }

  static final instance = CameraService._();
}
