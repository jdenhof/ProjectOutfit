import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/routing/app_router.dart';

class WardrobeBuilderPage extends ConsumerStatefulWidget {
  const WardrobeBuilderPage({super.key});

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true)
        .pushNamed(AppRoutes.wardrobeBuilderPage);
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WardrobeBuilderPage();
}

class _WardrobeBuilderPage extends ConsumerState<WardrobeBuilderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.wardrobeBuilderPage),
      ),
    );
  }
}
