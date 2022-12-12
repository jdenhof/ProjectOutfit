// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ootd/app/capture/camera_page.dart';
import 'package:ootd/app/home/home_view.dart';

import 'package:ootd/main.dart';

void main() {
  setUp() {
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
    );
    final auth = MockFirebaseAuth(
      mockUser: user,
      authExceptions: AuthExceptions(
        signInWithEmailAndPassword:
            FirebaseAuthException(code: 'invalid-credential'),
      ),
    );
  }

  testWidgets('OOTD Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.s

    await tester.pumpWidget(ProviderScope(overrides: [], child: HomeView()));

    expect(find.byIcon(Icons.photo_camera_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.camera_front));
    await tester.pump();

    expect(find.byIcon(Icons.camera_front), findsOneWidget);
  });
}
