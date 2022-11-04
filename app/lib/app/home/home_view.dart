import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/wardrobe.dart';
import 'package:ootd/app/services/firestore_database.dart';
import 'package:ootd/app/top_level_providers.dart';

// watch database
class HomeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.homePage),
        actions: <Widget>[
          IconButton(icon: const Icon(),)
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => {},
          ),
        ],
      ),
      body: _buildContents(context, ref),
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    //TODO~Start of home content view
    return Center(child: Text("HomeView"));
  }
}
