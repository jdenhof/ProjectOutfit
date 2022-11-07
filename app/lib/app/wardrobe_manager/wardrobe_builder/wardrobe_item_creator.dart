import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/routing/app_router.dart';
import 'package:ootd/app/top_level_providers.dart';

class WardrobeItemCreatorPage extends ConsumerStatefulWidget {
  const WardrobeItemCreatorPage({super.key});

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

  void _addTag(String newTag) {
    wardrobeItem.addNewTag(newTag);
    tagsController.text = '';
    setState(() {});
  }

  void _addImage(XFile item) {
    wardrobeItem.addImage(item);
  }

  @override
  void initState() {
    super.initState();

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
                const CancelButton(),
                ConfirmWidget(
                  onPressed: () {
                    if (WardrobeItemValidator.validator(wardrobeItem)) {
                      WardrobeItem item =
                          WardrobeItem.fromValidator(wardrobeItem);
                      item.image = wardrobeItem.image;
                      ref.read(databaseProvider)!.setWardrobeItem(item);
                      ref.read(storageProvider)!.addWardrobeItemImage(item);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        error = Strings.wardrobeItemError;
                      });
                    }
                  },
                ),
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
        StaticDisplay(
          name: wardrobeItem.nameLabel,
          category: wardrobeItem.categoryLabel,
          type: wardrobeItem.typeLabel,
          brand: wardrobeItem.brandLabel,
          tags: wardrobeItem.tagsLabel,
          imageCallpass: _addImage,
        ),
        // Error display
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(error),
          ),
        ),
        // . Info Input Section
        InfoInput(
          nameController: nameController,
          tagsController: tagsController,
          brandController: brandController,
          tagsCallback: _addTag,
          categoryCallpass: (category) => setState(
            () => wardrobeItem.category = category,
          ),
          typeCallpass: (type) => setState(
            () => wardrobeItem.type = type,
          ),
          category: wardrobeItem.currentCategory,
        ),
      ],
    );
  }
}

typedef OnPressedCallback = void Function();

//Confirms and adds Clothing item
class ConfirmWidget extends StatelessWidget {
  final OnPressedCallback onPressed;

  const ConfirmWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
      heroTag: "ConfirmButton",
      onPressed: onPressed,
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

class WardrobeItemValidator {
  String? name;
  String get nameLabel => "Name: ${name ?? ''}";

  String? category;
  String get currentCategory => category ?? '';
  String get categoryLabel => "Category: $currentCategory";

  String? type;
  String get typeLabel => "Type: ${type ?? ''}";

  String? brand;
  String get brandLabel => "Brand: ${brand ?? ''}";

  String get tagsLabel {
    String tags = '';
    for (var tag in currentTags) {
      tags == '' ? tags = tag : tags = "$tags, $tag";
    }
    return tags;
  }

  List<String> tagList = [];
  List<String> get currentTags => tagList;

  late XFile? image;

  void addNewTag(String newTag) {
    if (newTag != '') {
      tagList.add(newTag);
    }
  }

  void addImage(XFile item) {
    image = item;
  }

  //Returns true if clothing item contains required components
  //Required Components
  /// name - auto generated if none supplied
  /// category
  /// type
  //TODO ~ Pass invalid reasons to user
  static bool validator(WardrobeItemValidator item) {
    if (item.category == null || item.type == 'none') {
      return false;
    }
    if (item.type == null || item.type == 'none') {
      return false;
    }

    if (item.image == null) {
      return false;
    }

    item.name ??= "${item.brand ?? ''} ${item.type ?? ''}";

    return true;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'name': name,
      'wardrobeId': 'default',
      'category': category,
      'type': type,
      'brand': brand,
      'tags': tagList.toString(),
      'imagePath': image?.path.split('/').last,
    };
  }
}

typedef ImageCallpass = void Function(XFile);

//Display of upload/clothing widget
class StaticDisplay extends StatefulWidget {
  const StaticDisplay(
      {Key? key,
      required this.name,
      required this.category,
      required this.type,
      required this.brand,
      required this.tags,
      required this.imageCallpass})
      : super(key: key);
  final ImageCallpass imageCallpass;
  final String name;
  final String category;
  final String type;
  final String brand;
  final String tags;

  @override
  State<StaticDisplay> createState() => _StaticDisplayState();
}

class _StaticDisplayState extends State<StaticDisplay> {
  @override
  Widget build(BuildContext context) {
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
              imageCallback: widget.imageCallpass,
            ),
            //Clothing Item Data Section
            InfoDisplay(
              name: widget.name,
              category: widget.category,
              type: widget.type,
              brand: widget.brand,
              tags: widget.tags,
            ),
          ],
        ),
      ),
    );
  }
}

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
                    MaterialPageRoute(
                      builder: (context) => const CameraScreen(
                        display: false,
                        reciever: '',
                      ),
                    ),
                  )
                      .then((value) {
                    widget.imageCallback(value);
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

//Updated display of currently selected clothing item info
class InfoDisplay extends StatelessWidget {
  const InfoDisplay({
    Key? key,
    required this.name,
    required this.category,
    required this.type,
    required this.brand,
    required this.tags,
  }) : super(key: key);

  final String name;
  final String category;
  final String type;
  final String brand;
  final String tags;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: const EdgeInsets.only(top: 15.0, right: 10.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(brand, style: const TextStyle(fontWeight: FontWeight.bold)),
            TagsWidget(tags: tags),
          ],
        ),
      ),
    );
  }
}

//List of tags selected presented comma delemited
class TagsWidget extends StatelessWidget {
  const TagsWidget({
    Key? key,
    required this.tags,
  }) : super(key: key);

  final String tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          tags,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

typedef TextCallpass = void Function(String);
typedef CategoryCallpass = void Function(String);
typedef TypeCallpass = void Function(String);

class InfoInput extends StatelessWidget {
  final TextCallpass tagsCallback;
  final CategoryCallpass categoryCallpass;
  final TypeCallpass typeCallpass;
  final TextEditingController nameController;
  final TextEditingController tagsController;
  final TextEditingController brandController;
  final String category;

  const InfoInput({
    Key? key,
    required this.nameController,
    required this.tagsController,
    required this.brandController,
    required this.tagsCallback,
    required this.categoryCallpass,
    required this.typeCallpass,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                _NameInput(nameController: nameController),
                _CategoryInput(categoryCallpass: categoryCallpass),
                _TypeInput(category: category, typeCallback: typeCallpass),
                _BrandInput(brandController: brandController),
                _TagInput(
                    tagsController: tagsController, tagsCallback: tagsCallback),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Input widget for name selection
class _BrandInput extends StatelessWidget {
  final TextEditingController brandController;

  const _BrandInput({
    Key? key,
    required this.brandController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

//Input widget for name selection
class _NameInput extends StatelessWidget {
  const _NameInput({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
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
}

typedef TypeCallback = void Function(String);

class _TypeInput extends StatefulWidget {
  final TypeCallback typeCallback;
  final String category;
  const _TypeInput({
    Key? key,
    required this.typeCallback,
    required this.category,
  }) : super(key: key);

  @override
  State<_TypeInput> createState() => _TypeInputState();
}

class _TypeInputState extends State<_TypeInput> {
  String dropdownValue = 'none';
  @override
  Widget build(BuildContext context) {
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
            value: ClothingInfoBuilder.typeFromCategory(widget.category)
                    .contains(dropdownValue)
                ? dropdownValue
                : 'none',
            items: ClothingInfoBuilder.typeItems(widget.category),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
              widget.typeCallback(value);
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryInput extends StatelessWidget {
  const _CategoryInput({
    Key? key,
    required this.categoryCallpass,
  }) : super(key: key);

  final CategoryCallpass categoryCallpass;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          CategoryDropdown(
            categoryCallback: categoryCallpass,
          ),
        ],
      ),
    );
  }
}

typedef CategoryCallback = void Function(String);

class CategoryDropdown extends StatefulWidget {
  final CategoryCallback categoryCallback;
  const CategoryDropdown({
    Key? key,
    required this.categoryCallback,
  }) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String dropdownValue = ClothingInfoBuilder.categorys.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      items: ClothingInfoBuilder.categoryItems(),
      onChanged: ((value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.categoryCallback(value);
      }),
    );
  }
}

class ClothingInfoBuilder {
  static const categorys = ['none', 'headwear', 'top', 'bottom', 'footwear'];
  static const headwear = ['none', 'hat', 'scarf'];
  static const top = [
    'none',
    't-shirt',
    'long-sleeve',
    'sweatshirt',
    'dress',
    'sweater',
    'tank top',
    'crew neck',
    'jacket',
    'button down',
    'vest'
  ];

  static const bottom = [
    'none',
    'sweatpants',
    'jeans',
    'shorts',
    'jogger pants',
    'khakis',
    'dress pants'
  ];

  static const footwear = ['none', 'socks', 'sneakers', 'boots', 'dress shoes'];

  static List<DropdownMenuItem<dynamic>> categoryItems() {
    return ClothingInfoBuilder.categorys
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
  }

  static typeFromCategory(String category) {
    List<String> tmp = [];
    switch (category) {
      case ('headwear'):
        tmp = ClothingInfoBuilder.headwear;
        break;
      case ('top'):
        tmp = ClothingInfoBuilder.top;
        break;
      case ('bottom'):
        tmp = ClothingInfoBuilder.bottom;
        break;
      case ('footwear'):
        tmp = ClothingInfoBuilder.footwear;
        break;
      default:
        tmp = ['none'];
        break;
    }
    return tmp;
  }

  static List<DropdownMenuItem<dynamic>> typeItems(String category) {
    List<String> tmp = typeFromCategory(category);
    return tmp.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();
  }
}

typedef TextCallback = void Function(String);

//Tag input selection widget
class _TagInput extends StatelessWidget {
  final TextEditingController tagsController;
  final TextCallback tagsCallback;
  const _TagInput({
    Key? key,
    required this.tagsController,
    required this.tagsCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => tagsCallback(tagsController.text),
                ),
                hintText: "Enter tag here..."),
          ),
        ],
      ),
    );
  }
}
