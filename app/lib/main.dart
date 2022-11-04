import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ootd/riverpod/top_level_providers.dart';
import 'package:ootd/riverpod/auth_widget.dart';
import 'package:ootd/riverpod/signin_page.dart';
import 'package:ootd/riverpod/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: AuthWidget(
        nonSignedInBuilder: (_) => Consumer(
          builder: (context, ref, _) => SignInPage(),
        ),
        signedInBuilder: (_) => const Center(child: Text("hello")),
      ),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
