import 'package:flutter/material.dart';
import 'package:ootd/src/components/clothe_factory/clothe_widgets.dart';
import 'package:ootd/src/components/clothe_factory/info_display.dart';
import 'package:ootd/src/components/clothe_factory/info_input.dart';
import 'package:ootd/src/components/clothe_factory/clothe_item.dart';

class _ClotheFactoryState extends State<ClotheFactory> {
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final clothingItem = ClothingItem();

  final tagsController = TextEditingController();

  void _addTag(String newTag) {
    clothingItem.addNewTag(newTag);
    tagsController.text = '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    nameController.addListener(
      () => setState(() {
        clothingItem.name = nameController.text;
      }),
    );

    brandController.addListener(
      () => setState(() {
        clothingItem.brand = brandController.text;
      }),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    tagsController.dispose();
    brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(title: const Text("New Outfit")),
      //Main Scaffold Column
      body: Flex(
        direction: Axis.vertical,
        children: [
          //Clothing Item Info
          StaticDisplay(
            name: clothingItem.nameLabel,
            category: clothingItem.categoryLabel,
            type: clothingItem.typeLabel,
            brand: clothingItem.brandLabel,
            tags: clothingItem.tagsLabel,
          ),
          //Info Input Section
          InfoInput(
            nameController: nameController,
            tagsController: tagsController,
            brandController: brandController,
            tagsCallback: _addTag,
            categoryCallpass: (category) => setState(
              () => clothingItem.category = category,
            ),
            typeCallpass: (type) => setState(
              () => clothingItem.type = type,
            ),
            category: clothingItem.currentCategory,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                const CancelButton(),
                ConfirmWidget(
                  clothingItem: clothingItem,
                ),
              ],
            )
          : null,
    );
  }
}

class ClotheFactory extends StatefulWidget {
  const ClotheFactory({super.key});

  static const routeName = "/clotheFactory";

  @override
  State<ClotheFactory> createState() => _ClotheFactoryState();
}
