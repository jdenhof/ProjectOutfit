import 'package:flutter/material.dart';
import 'package:ootd/src/navigation/factory/clothe_factory.dart';

class _WardrobeFactoryState extends State<WardrobeFactory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wardrobe Editor")),
      body: const Center(child: Text("Wardrobe Editor")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.of(context).pushNamed(ClotheFactory.routeName),
        label: const Icon(Icons.add),
      ),
    );
  }
}

class WardrobeFactory extends StatefulWidget {
  const WardrobeFactory({super.key});

  static const routeName = "/wardrobeFactory";

  @override
  State<StatefulWidget> createState() => _WardrobeFactoryState();
}
