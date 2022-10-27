import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ootd/src/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //TODO~Pass warning to ui
  cameras = await availableCameras();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outfit of the Day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
    );
  }
}
