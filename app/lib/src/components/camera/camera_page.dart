import 'package:camera/camera.dart';
import 'package:ootd/src/app.dart';
import 'package:ootd/src/components/camera/display_page.dart';

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
      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  void takePicture() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = _controller;

    if (cameraController.value.isInitialized) {
      if (state == AppLifecycleState.inactive) {
        cameraController.dispose();
      } else if (state == AppLifecycleState.resumed) {
        initCamera();
      }
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
      appBar: AppBar(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          flipCameraActionButton(),
          takePictureActionButton(),
        ],
      ),
    );
  }

  Expanded flipCameraActionButton() {
    return Expanded(
      flex: 1,
      child: FloatingActionButton(
        heroTag: 'FlipCamera',
        onPressed: () async {
          _initializeControllerFuture.whenComplete(() {
            rearCameraSelected = !rearCameraSelected;
            setState(() {
              initCamera();
            });
          });
        },
        child: Icon(
          rearCameraSelected ? Icons.camera_front : Icons.photo_camera_back,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Expanded takePictureActionButton() {
    return Expanded(
      flex: 1,
      child: FloatingActionButton(
        heroTag: 'TakePicture',
        onPressed: takePicture,
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
