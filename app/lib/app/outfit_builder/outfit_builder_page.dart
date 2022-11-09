import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/routing/app_router.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Outfit builder page"),
      ),
    );
  }
}
