import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/home/components/date_display.dart';
import 'package:ootd/app/home/components/weather.dart';
import 'package:ootd/app/routing/app_router.dart';
import 'package:ootd/app/top_level_providers.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_page/wardrobe_manager_page.dart';

// watch database
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(firebaseAuthProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.homePage),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            selectedIcon: const Icon(Icons.logout),
            onPressed: () => authProvider.signOut(),
          ),
          IconButton(
            icon: const Icon(Icons.checkroom_outlined, color: Colors.white),
            onPressed: () => WardrobeManagerPage.show(context),
            selectedIcon: const Icon(Icons.checkroom),
          ),
        ],
      ),
      body: _buildContents(authProvider, context, ref),
    );
  }

  Widget _buildContents(
      FirebaseAuth auth, BuildContext context, WidgetRef ref) {
    // TODO: Start of home content view
    return Column(
      children: [
        const WeatherDisplay(),
        const DateDisplay(),
        ElevatedButton(
          onPressed: () => CameraScreen.show(
              context,
              CameraArguments(
                  reciever: AppRoutes.outfitBuilderPage, display: true)),
          child: const Text("Add Outfit"),
        ),
      ],
    );
  }
}
