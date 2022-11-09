import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/routing/app_router.dart';

class DisplayArguments {
  final XFile image;
  final CameraArguments cameraArgs;

  DisplayArguments({required this.image, required this.cameraArgs});
}

class CameraDisplay extends ConsumerStatefulWidget {
  const CameraDisplay({super.key});

  static Future<void> show(
      BuildContext context, XFile image, CameraArguments arguments) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.cameraDisplay,
        arguments: DisplayArguments(image: image, cameraArgs: arguments));
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraDisplay();
}

class _CameraDisplay extends ConsumerState<CameraDisplay> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DisplayArguments;
    final cameraArgs = args.cameraArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.outfitDisplayPage),
      ),
    );
  }
}
