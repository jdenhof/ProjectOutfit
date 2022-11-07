import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/top_level_providers.dart';

//Wardrobe - List Tile
class WardrobeItemListTile extends ConsumerWidget {
  const WardrobeItemListTile({Key? key, required this.wardrobeItem, this.onTap})
      : super(key: key);
  final WardrobeItem wardrobeItem;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(storageProvider);
    Future<Uint8List?> image = storage!.getWardrobeItemImage(wardrobeItem);
    return ListTile(
      title: Text(wardrobeItem.name),
      leading: FutureBuilder(
        future: image,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image(image: MemoryImage(snapshot.data!));
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
