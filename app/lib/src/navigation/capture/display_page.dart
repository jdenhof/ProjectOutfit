import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ootd/src/navigation/factory/outfit_factory.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushReplacementNamed(context, OutfitFactory.routeName,
              arguments: imagePath)
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
