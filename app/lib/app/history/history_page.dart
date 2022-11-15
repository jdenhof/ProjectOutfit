import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/outfit_item.dart';
import 'package:ootd/app/routing/app_router.dart';
import 'package:ootd/app/top_level_providers.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_page/wardrobe_manager_page.dart';

// watch database
class HistoryPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  Widget _outfitPreview(OutfitItem item) {
    final storage = ref.watch(storageProvider);
    final image = storage!.getOutfitItemImage(item);
    return Container(
      height: 150.0,
      child: Row(
        children: [
          FutureBuilder(
            future: image,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  return Image(
                    image: MemoryImage(snapshot.data!),
                  );
              }
            },
          ),
          Center(
              child: Column(
            children: [
              Text("Name: ${item.name}"),
              Text("Category: ${item.category}"),
            ],
          ))
        ],
      ),
    );
  }

  List<Widget> _outfitPreviewFromOutfits(List<OutfitItem> snapshot) {
    List<Widget> widgets = [];
    for (OutfitItem item in snapshot) {
      widgets.add(_outfitPreview(item));
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
    //TODO~Start of home content view
    final database = ref.watch(databaseProvider);
    final outfits = database!.outfitItemsStream();
    return StreamBuilder(
      stream: outfits,
      builder:
          (BuildContext context, AsyncSnapshot<List<OutfitItem>> snapshot) {
        List<Widget> children;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            children = [];
            break;
          case ConnectionState.waiting:
            children = [CircularProgressIndicator()];
            break;
          case ConnectionState.active:
            children = _outfitPreviewFromOutfits(snapshot.data!);
            break;
          case ConnectionState.done:
            children = _outfitPreviewFromOutfits(snapshot.data!);
            break;
        }

        return ListView(
          children: children,
        );
      },
    );
  }
}
