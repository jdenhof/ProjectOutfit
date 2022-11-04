import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ootd/riverpod/top_level_providers.dart';

class SignInPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  String errorMessage = '';

  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword(FirebaseAuth auth) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword(FirebaseAuth auth) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  Widget _title() {
    return const Text('Authentication');
  }

  Widget _entryFeild(
    String title,
    TextEditingController controller,
    bool obscure,
  ) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Error : $errorMessage');
  }

  Widget _submitButton(FirebaseAuth auth) {
    return ElevatedButton(
      onPressed: () => isLogin
          ? signInWithEmailAndPassword(auth)
          : createUserWithEmailAndPassword(auth),
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register Instead' : 'Login Instead'));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(firebaseAuthProvider);
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryFeild('email', _controllerEmail, false),
            _entryFeild('password', _controllerPassword, true),
            _errorMessage(),
            _loginOrRegisterButton(),
            _submitButton(authProvider),
          ],
        ),
      ),
    );
  }
}
