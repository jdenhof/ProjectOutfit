import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/capture/display_page.dart';
import 'package:ootd/app/outfit_builder/outfit_builder_page.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_builder/wardrobe_builder_page.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_creator.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_page/wardrobe_manager_page.dart';
import 'package:ootd/app/auth/signin_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const wardrobeManagerPage = '/wardrobe-manager-page';
  static const wardrobeBuilderPage = '/wardrobe-builder-page';
  static const wardrobeItemCreatorPage = '/wardrobe-item-creator-page';
  static const outfitBuilderPage = '/outfit-builder-page';
  static const cameraDisplay = '/camera-display-page';
  static const cameraScreen = '/camera-screen-page';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(
      RouteSettings settings, FirebaseAuth firebaseAuth) {
    switch (settings.name) {
      case AppRoutes.emailPasswordSignInPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignInPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.wardrobeManagerPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const WardrobeManagerPage(),
          settings: settings,
        );
      case AppRoutes.wardrobeBuilderPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const WardrobeBuilderPage(),
          settings: settings,
        );
      case AppRoutes.wardrobeItemCreatorPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const WardrobeItemCreatorPage(),
          settings: settings,
        );
      case AppRoutes.outfitBuilderPage:
        return MaterialPageRoute(
          builder: (_) => const OutfitBuilderPage(),
          settings: settings,
        );
      case AppRoutes.cameraDisplay:
        return MaterialPageRoute(
          builder: (_) => const CameraDisplay(),
          settings: settings,
        );
      case AppRoutes.cameraScreen:
        return MaterialPageRoute(
          builder: (_) => const CameraScreen(),
          settings: settings,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}
