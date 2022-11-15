import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/outfit_item.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/routing/app_router.dart';
import 'package:ootd/app/services/firestore_path.dart';
import 'package:ootd/app/top_level_providers.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_info_builder.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_validator.dart';

class OutfitBuilderPage extends ConsumerStatefulWidget {
  const OutfitBuilderPage({super.key});

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true)
        .pushNamed(AppRoutes.outfitBuilderPage);
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OutfitBuilderPage();
}

class _OutfitBuilderPage extends ConsumerState<OutfitBuilderPage> {
  final _wardrobeItemId = [];

  void _wardrobeItemIdChange(String uid) {
    if (_wardrobeItemId.contains(uid)) {
      _wardrobeItemId.remove(uid);
    } else {
      _wardrobeItemId.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as OutfitBuilderArguments;
    final database = ref.watch(databaseProvider);
    final storage = ref.watch(storageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Outfit builder page"),
      ),
      body: _buildContents(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          storage!.setOutfitImage(args.image);
          database!.setOutfit(
            OutfitItem(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              name: '',
              category: '',
              tags: '',
              imagePath: FirestorePath.outfitImage(
                  database.uid, args.image.path.split('/').last),
            ),
          );
          Navigator.of(context)
            ..pop()
            ..pop();
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildContents(context) {
    return Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          wardrobeItemSelector("headwear"),
          wardrobeItemSelector("top"),
          wardrobeItemSelector("bottom"),
          wardrobeItemSelector("footwear"),
        ],
      ),
    );
  }

  Widget wardrobeItemSelector(String category) {
    final database = ref.watch(databaseProvider)!;
    final wardrobeItemStream =
        database.wardrobeItemsStreamFromCategory(category);
    final storage = ref.watch(storageProvider);
    return StreamBuilder(
      stream: wardrobeItemStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<WardrobeItem>> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          children = [Container(height: 100.0, child: Icon(Icons.error))];
        } else if (snapshot.hasData) {
          children = [
            Container(
              height: 150.0,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(category,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 100.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var item in snapshot.data!)
                          Container(
                            height: 100.0,
                            color: Colors.blue,
                            child: FutureBuilder(
                              future: storage!.getWardrobeItemImage(item),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ImageSelector(
                                    item: item,
                                    image: snapshot.data!,
                                    selectedCallback: _wardrobeItemIdChange,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("Error");
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        } else {
          children = [
            Container(height: 100.0, child: CircularProgressIndicator())
          ];
        }
        return Column(children: children);
      },
    );
  }
}

typedef SelectedCallback = void Function(String uid);

class ImageSelector extends StatefulWidget {
  ImageSelector({
    Key? key,
    required this.item,
    required this.image,
    required this.selectedCallback,
  }) : super(key: key);

  WardrobeItem item;
  Uint8List image;
  SelectedCallback selectedCallback;

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  bool chosen = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() => chosen = !chosen);
          widget.selectedCallback(widget.item.id);
        },
        child: Image(
          color: chosen ? Colors.grey : null,
          colorBlendMode: BlendMode.lighten,
          image: MemoryImage(widget.image),
        ));
  }
}

class OutfitBuilderArguments {
  final XFile image;

  OutfitBuilderArguments({required this.image});
}