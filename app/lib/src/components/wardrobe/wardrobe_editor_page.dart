import 'package:flutter/material.dart';

class _WardrobeEditorPageState extends State<WardrobeEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe Editor')),
    );
  }
}

class WardrobeEditorPage extends StatefulWidget {
  const WardrobeEditorPage(Key? key) : super(key: key);

  @override
  State<WardrobeEditorPage> createState() => _WardrobeEditorPageState();
}
