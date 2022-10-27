import 'package:flutter/material.dart';

class _OutfitSelectorState extends State<OutfitSelector> {
  // ignore: unused_element
  Widget _clothingItemSelector() {
    return ListWheelScrollView(itemExtent: 40, children: const <Widget>[]);
  }

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

class OutfitSelector extends StatefulWidget {
  const OutfitSelector({Key? key}) : super(key: key);

  static const routeName = 'outfitSelector';

  @override
  State<OutfitSelector> createState() => _OutfitSelectorState();
}
