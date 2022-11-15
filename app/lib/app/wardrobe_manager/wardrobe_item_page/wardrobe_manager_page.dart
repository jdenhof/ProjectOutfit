import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/routing/app_router.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_creator.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_page/wardrobe_list_builder.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_page/wardrobe_list_tile.dart';
import 'package:ootd/app/top_level_providers.dart';

final wardrobeItemsStreamProvider =
    StreamProvider.autoDispose<List<WardrobeItem>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.wardrobeItemsStream(null);
});

class WardrobeManagerPage extends ConsumerStatefulWidget {
  const WardrobeManagerPage({super.key});

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true)
        .pushNamed(AppRoutes.wardrobeManagerPage);
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WardrobeManagerPage();
}

class _WardrobeManagerPage extends ConsumerState<WardrobeManagerPage> {
  Future<void> _delete(WardrobeItem item) async {
    try {
      final database = ref.read(databaseProvider)!;
      final storage = ref.read(storageProvider)!;
      await database.deleteWardrobeItem(item);
      await storage.deleteWardrobeItem(item);
    } catch (e) {
      // TODO: Pass error to user
      throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.wardrobeManagerDesc),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => WardrobeItemCreatorPage.show(context),
          )
        ],
      ),
      body: _buildContents(context, ref),
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    final wardrobeItemsAsyncValue = ref.watch(wardrobeItemsStreamProvider);
    return WardrobeListItemsBuilder<WardrobeItem>(
      data: wardrobeItemsAsyncValue,
      itemBuilder: (context, item) => Dismissible(
        key: Key('wardrobe-${item.id}'),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _delete(item),
        child: WardrobeItemListTile(
          wardrobeItem: item,
          //TODO: Open editor page
          onTap: () => {},
        ),
      ),
    );
  }
}
