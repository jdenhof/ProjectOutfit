import 'package:flutter/material.dart';

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
      tags == '' ? tags = "$tag" : tags = "$tags, $tag";
    }
    return tags;
  }

  List<String> currentTags = [
    "test",
    "test",
    "test",
    "test",
    "test",
    "test",
  ];

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
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
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
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              child: Flexible(
                flex: 1,
                child: Row(
                  children: [
                    //Upload Photo Section
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.upload_file,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                    //Clothing Item Data Section
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(top: 15.0, right: 10.0),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name),
                            Text(category),
                            Text(type),
                            Text(brand),
                            _TagsWidget(tags: tags),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Info Input Section
          Flexible(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name:"),
                        TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                hintText: "Enter name here...")),
                        const Text("Tags:"),
                        TextField(
                            controller: tagsController,
                            decoration: const InputDecoration(
                                hintText: "Enter name here..."))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _CancelButton(),
          _ConfirmWidget(),
        ],
      ),
    );
  }
}

class _TagsWidget extends StatelessWidget {
  const _TagsWidget({
    Key? key,
    required this.tags,
  }) : super(key: key);

  final String tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags:"),
        Text(
          tags,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

class _ConfirmWidget extends StatelessWidget {
  const _ConfirmWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.green,
      child: const Icon(Icons.check),
    ));
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Icon(Icons.delete_forever_outlined),
    ));
  }
}

class ClotheFactory extends StatefulWidget {
  const ClotheFactory({super.key});

  static const routeName = "/clotheFactory";

  @override
  State<ClotheFactory> createState() => _ClotheFactoryState();
}
