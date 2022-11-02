import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final XFile imagePath;
  final String reciever;

  const DisplayPictureScreen(
      {super.key, required this.reciever, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath.path)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            {Navigator.pushNamed(context, reciever, arguments: imagePath)},
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
