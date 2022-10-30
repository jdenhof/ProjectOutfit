import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ootd/src/navigation/factory/outfit_factory.dart';
import 'package:ootd/src/navigation/factory/wardrobe_factory.dart';
import 'package:ootd/src/navigation/auth_pages/auth_router.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        initialRoute: '/',
        routes: {
          '/': ((context) => const AuthRouter()),
          OutfitFactory.routeName: (context) => const OutfitFactory(),
          WardrobeFactory.routeName: (context) => const WardrobeFactory(),
        });
  }
}
