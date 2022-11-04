import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ootd/riverpod/signin_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
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
      default:
        // TODO: Throw
        return null;
    }
  }
}
