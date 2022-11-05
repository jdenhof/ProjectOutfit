import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/top_level_providers.dart';
import 'package:ootd/app/routing/app_router.dart';

// watch database
class HomeView extends ConsumerStatefulWidget {
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
            icon: Icon(Icons.logout_outlined),
            selectedIcon: Icon(Icons.logout),
            onPressed: () => authProvider.signOut(),
          ),
          IconButton(
            icon: const Icon(Icons.checkroom_outlined, color: Colors.white),
            onPressed: () => WardrobeManagerPage.show(context),
            selectedIcon: Icon(Icons.checkroom),
          ),
        ],
      ),
      body: _buildContents(authProvider, context, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }

  Widget _buildContents(
      FirebaseAuth auth, BuildContext context, WidgetRef ref) {
    //TODO~Start of home content view
    return Center(child: Text(auth.currentUser?.email ?? ''));
  }
}
