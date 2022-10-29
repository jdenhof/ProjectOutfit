import 'package:flutter/material.dart';
import 'package:ootd/src/auth/auth.dart';
import 'package:ootd/src/navigation/home_page.dart';
import 'package:ootd/src/navigation/auth_pages/login_page.dart';

class _AuthRouterState extends State<AuthRouter> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

class AuthRouter extends StatefulWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  State<AuthRouter> createState() => _AuthRouterState();
}
