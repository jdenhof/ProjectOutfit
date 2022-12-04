import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/outfit_item.dart';
import 'package:ootd/app/top_level_providers.dart';

// watch database
class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  Widget _outfitPreview(OutfitItem outfit, bool altColor) {
    final storage = ref.watch(storageProvider);
    final outfitImage = storage!.getOutfitItemImage(outfit);
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 100,
      color: altColor ? Colors.grey : null,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  DateTime.fromMicrosecondsSinceEpoch(int.parse(outfit.id))
                      .toIso8601String(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  child: FutureBuilder(
                    future: outfitImage,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("reload");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const CircularProgressIndicator();
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        case ConnectionState.active:
                          return const CircularProgressIndicator();
                        case ConnectionState.done:
                          return Image(
                            image: MemoryImage(snapshot.data!),
                          );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: outfit.items.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _itemImage(outfit.items[index], ref),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemImage(String imagePath, WidgetRef ref) {
    final storage = ref.watch(storageProvider)!;
    final itemImage = storage.getWardrobeItemImage(imagePath);
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: FutureBuilder(
        future: itemImage,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("reload");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const CircularProgressIndicator();
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              return Image(
                height: 100.0,
                width: 100.0,
                image: MemoryImage(snapshot.data!),
              );
          }
        },
      ),
    );
  }

  List<Widget> _outfitPreviewFromOutfits(List<OutfitItem> snapshot) {
    List<Widget> widgets = [];
    bool alt = true;
    for (OutfitItem item in snapshot) {
      widgets.insert(0, _outfitPreview(item, alt = !alt));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(firebaseAuthProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.historyPage),
        centerTitle: true,
      ),
      body: _buildContents(authProvider, context, ref),
    );
  }

  Widget _buildContents(
      FirebaseAuth auth, BuildContext context, WidgetRef ref) {
    // TODO: start of home content view
    final database = ref.watch(databaseProvider);
    final outfits = database!.outfitItemsStream();
    return StreamBuilder(
      stream: outfits,
      builder:
          (BuildContext context, AsyncSnapshot<List<OutfitItem>> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          throw snapshot.error!;
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            children = [];
            break;
          case ConnectionState.waiting:
            children = [const CircularProgressIndicator()];
            break;
          case ConnectionState.active:
            children = snapshot.hasData
                ? _outfitPreviewFromOutfits(snapshot.data!)
                : [const LinearProgressIndicator()];
            break;
          case ConnectionState.done:
            children = _outfitPreviewFromOutfits(snapshot.data!);
            break;
        }

        return Container(
          margin: const EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: children,
          ),
        );
      },
    );
  }
}
