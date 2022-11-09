import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/routing/app_router.dart';

class CameraDisplay extends ConsumerStatefulWidget {
  const CameraDisplay({super.key});

  static Future<void> show(BuildContext context, XFile image) async {
    await Navigator.of(context, rootNavigator: true)
        .pushNamed(AppRoutes.cameraDisplay, arguments: image);
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraDisplay();
}

class _CameraDisplay extends ConsumerState<CameraDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.wardrobeBuilderPage),
      ),
    );
  }
}
