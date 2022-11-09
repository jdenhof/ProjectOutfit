import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/routing/app_router.dart';

typedef ImageCallback = void Function(XFile);

//Displays upload photo button then displays photo, tap to change
class UploadPhoto extends StatefulWidget {
  const UploadPhoto({
    Key? key,
    required this.imageCallback,
  }) : super(key: key);

  final ImageCallback imageCallback;

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: image == null
              ? ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .push(
                    MaterialPageRoute<XFile>(
                      builder: (BuildContext context) => CameraScreen(),
                      settings: RouteSettings(
                          arguments:
                              CameraArguments(display: false, reciever: '')),
                    ),
                  )
                      .then((value) {
                    widget.imageCallback(value!);
                    setState(() {
                      image = value;
                    });
                  }),
                  child: const Icon(
                    Icons.upload_file,
                    size: 100,
                  ),
                )
              : Image.file(File(image!.path))),
    );
  }
}
