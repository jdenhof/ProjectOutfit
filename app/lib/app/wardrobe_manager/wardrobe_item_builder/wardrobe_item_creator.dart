import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/capture/upload_image_button.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/routing/app_router.dart';
import 'package:ootd/app/top_level_providers.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_info_builder.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_validator.dart';

class WardrobeItemCreatorPage extends ConsumerStatefulWidget {
  WardrobeItemCreatorPage(
    this.initializer, {
    super.key,
  });

  WardrobeItem? initializer;

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true)
        .pushNamed(AppRoutes.wardrobeItemCreatorPage);
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WardrobeItemCreatorPage();
}

class _WardrobeItemCreatorPage extends ConsumerState<WardrobeItemCreatorPage> {
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final wardrobeItem = WardrobeItemValidator();
  final tagsController = TextEditingController();

  late String error = '';

  late String categoryDropdownValue = 'none';
  late String typeDropdownValue = 'none';

  void _addTag(String newTag) {
    wardrobeItem.addNewTag(newTag);
    tagsController.text = '';
    setState(() {});
  }

  void _addImage(XFile item) {
    wardrobeItem.addImage(item);
    setState(() => {});
  }

  void _validateWardrobe() {
    {
      try {
        if (WardrobeItemValidator.validator(wardrobeItem)) {
          WardrobeItem item = WardrobeItem.fromValidator(wardrobeItem);
          item.image = wardrobeItem.image;
          ref.read(databaseProvider)!.setWardrobeItem(item);
          ref.read(storageProvider)!.addWardrobeItemImage(item);
          Navigator.pop(context);
        } else {
          setState(() {
            error = Strings.wardrobeItemError;
          });
        }
      } catch (e) {
        setState(() => error = Strings.noImageFail);
        throw UnimplementedError();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initializer != null) {
      wardrobeItem.category = widget.initializer!.category;
      wardrobeItem.name = widget.initializer!.name;
      wardrobeItem.brand = widget.initializer!.brand;
    }
    // Start listening to changes.
    nameController.addListener(
      () => setState(() {
        wardrobeItem.name = nameController.text;
      }),
    );

    brandController.addListener(
      () => setState(() {
        wardrobeItem.brand = brandController.text;
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
      appBar: AppBar(
        title: Text(Strings.wardrobeItemCreatorPage),
      ),
      body: _buildContents(context, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                _cancelButton(context),
                _confirmButton(context),
              ],
            )
          : null,
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    return Flex(
      direction: Axis.vertical,
      children: [
        // Clothing Item Info
        _staticDisplay(context),
        // Error display
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(error),
          ),
        ),
        // . Info Input Section
        _infoInput(context)
      ],
    );
  }

  Widget _staticDisplay(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.lightBlue[50],
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            //Upload Photo Section
            UploadPhoto(
              imageCallback: _addImage,
            ),
            //Clothing Item Data Section
            _infoDisplay(context),
          ],
        ),
      ),
    );
  }

  Widget _infoDisplay(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: const EdgeInsets.only(top: 15.0, right: 10.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text(wardrobeItem.nameLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(wardrobeItem.categoryLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(wardrobeItem.typeLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(wardrobeItem.brandLabel,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            _tagsWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
      heroTag: "ConfirmButton",
      onPressed: () => _validateWardrobe(),
      backgroundColor: Colors.green,
      child: const Icon(Icons.check),
    ));
  }

  Widget _cancelButton(BuildContext context) {
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

  Widget _tagsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          wardrobeItem.tags,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  Widget _infoInput(BuildContext context) {
    return Flexible(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameInput(context),
                _categoryInput(context),
                _typeInput(context),
                _brandInput(context),
                _tagInput(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _brandInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Brand:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: brandController,
          decoration: const InputDecoration(hintText: "brand..."),
        ),
      ],
    );
  }

  Widget _nameInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "(auto)"),
        ),
      ],
    );
  }

  Widget _typeInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Type:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            value: typeDropdownValue,
            items: ClothingInfoBuilder.typeItems(categoryDropdownValue),
            onChanged: (value) {
              setState(() {
                typeDropdownValue = value;
                wardrobeItem.type = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _categoryInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _categoryDropdown(context),
        ],
      ),
    );
  }

  Widget _categoryDropdown(BuildContext context) {
    return DropdownButton(
      value: categoryDropdownValue,
      items: ClothingInfoBuilder.categoryItems(),
      onChanged: ((value) {
        setState(() {
          categoryDropdownValue = value;
          wardrobeItem.category = value;
        });
      }),
    );
  }

  Widget _tagInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tags: Events, Descriptions...",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            textInputAction: TextInputAction.done,
            controller: tagsController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _addTag(tagsController.text),
                ),
                hintText: "Enter tag here..."),
          ),
        ],
      ),
    );
  }
}
