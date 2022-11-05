import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/models/wardrobe.dart';
import 'package:ootd/app/services/firestore_services.dart';
import 'package:ootd/app/top_level_providers.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/signin_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const wardrobeManagerPage = '/wardrobeManagerPage';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(
      RouteSettings settings, FirebaseAuth firebaseAuth) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.emailPasswordSignInPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignInPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.wardrobeManagerPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => WardrobeManagerPage(),
          settings: settings,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}

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
  List<Widget> _wardrobes(List<Wardrobe> wardrobes) {
    return wardrobes.map(
      ((e) {
        return Text(e.name);
      }),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(databaseProvider);
    final wardrobes = database!.wardrobesStream().first;
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.wardrobeManagerDesc),
        ),
        body: FutureBuilder(
          future: wardrobes,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: _wardrobes(snapshot.data!),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            throw UnimplementedError();
          },
        ));
  }
}
