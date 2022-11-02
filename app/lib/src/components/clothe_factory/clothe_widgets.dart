import 'package:flutter/material.dart';
import 'package:ootd/src/components/clothe_factory/clothe_item.dart';

//Confirms and adds Clothing item
class ConfirmWidget extends StatelessWidget {
  final ClothingItem clothingItem;
  const ConfirmWidget({
    Key? key,
    required this.clothingItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
      heroTag: "ConfirmButton",
      onPressed: (() => ClothingItem.validator(clothingItem)),
      backgroundColor: Colors.green,
      child: const Icon(Icons.check),
    ));
  }
}

//Cancels and pops navigation
class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
      heroTag: "CancelButton",
      backgroundColor: Colors.red,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Icon(Icons.delete_forever_outlined),
    ));
  }
}
