import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_builder/wardrobe_builder_page.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_creator.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_manager_page/wardrobe_manager_page.dart';
import 'package:ootd/app/auth/signin_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const wardrobeManagerPage = '/wardrobe-manager-page';
  static const wardrobeBuilderPage = '/wardrobe-builder-page';
  static const wardrobeItemCreatorPage = '/wardrobe-item-creator-page';
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
      case AppRoutes.wardrobeBuilderPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => WardrobeBuilderPage(),
          settings: settings,
        );
      case AppRoutes.wardrobeItemCreatorPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => WardrobeItemCreatorPage(null),
          settings: settings,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}
