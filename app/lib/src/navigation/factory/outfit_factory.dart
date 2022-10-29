import 'package:flutter/material.dart';

class _OutfitFactoryState extends State<OutfitFactory> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(arg),
      ),
    );
  }
}

class OutfitFactory extends StatefulWidget {
  const OutfitFactory({Key? key}) : super(key: key);

  static const routeName = '/outfitFactory';

  @override
  State<OutfitFactory> createState() => _OutfitFactoryState();
}
