import 'package:flutter/material.dart';
import 'package:ootd/src/components/clothe_factory/clothing_info.dart';
import 'package:ootd/src/components/clothe_factory/clothe_widgets.dart';

class _ClotheFactoryState extends State<ClotheFactory> {
  final nameController = TextEditingController();
  String nameLabel = '';
  String get name => "Name: $nameLabel";

  String categorylabel = '';
  String get category => "Category: $categorylabel";

  String typeLabel = '';
  String get type => "Type: $typeLabel";

  String brandLabel = '';
  String get brand => "Brand: $brandLabel";

  final tagsController = TextEditingController();

  String get tags {
    String tags = '';
    for (var tag in currentTags) {
      tags == '' ? tags = tag : tags = "$tags, $tag";
    }
    return tags;
  }

  List<String> currentTags = [];

  void _addTag(String newTag) {
    if (newTag != '') {
      currentTags.add(newTag);
      tagsController.text = '';
      setState(() {});
    }
  }

  void _categoryChanged(String category) {
    setState(() {
      categorylabel = category;
    });
  }

  void _typeChanged(String type) {
    setState(() {
      typeLabel = type;
    });
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    nameController.addListener(
      () => setState(() {
        nameLabel = nameController.text;
      }),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Outfit")),
      //Main Scaffold Column
      body: Flex(
        direction: Axis.vertical,
        children: [
          //Clothing Item Info
          StaticDisplay(
              name: name,
              category: category,
              type: type,
              brand: brand,
              tags: tags),
          //Info Input Section
          InfoInput(
            nameController: nameController,
            tagsController: tagsController,
            tagsCallback: _addTag,
            categoryCallpass: _categoryChanged,
            typeCallpass: _typeChanged,
            category: categorylabel,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.horizontal,
        children: const [
          CancelButton(),
          ConfirmWidget(),
        ],
      ),
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

  const InfoInput({
    Key? key,
    required this.nameController,
    required this.tagsController,
    required this.tagsCallback,
    required this.categoryCallpass,
    required this.typeCallpass,
    required this.category,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController tagsController;
  final String category;

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
                _TypeInput(
                  category: category,
                  typeCallback: typeCallpass,
                ),
                _TagInput(
                  tagsController: tagsController,
                  tagsCallback: tagsCallback,
                ),
              ],
            ),
          ],
        ),
      ),
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

class ClotheFactory extends StatefulWidget {
  const ClotheFactory({super.key});

  static const routeName = "/clotheFactory";

  @override
  State<ClotheFactory> createState() => _ClotheFactoryState();
}
