import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikebite/utils/auth.dart';
import 'package:hikebite/utils/dimensions.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? error = '';
  bool isLogin = true;

  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _textControllerEmail.text,
        password: _textControllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _textControllerEmail.text,
        password: _textControllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.login,
            size: 64,
            color: colorScheme.primary,
          ),
          const SizedBox(height: Dimensions.DIVIDER_SIZE_SMALL),
          TextField(
            controller: _textControllerEmail,
            decoration: const InputDecoration(labelText: "email"),
          ),
          TextField(
            controller: _textControllerPassword,
            decoration: const InputDecoration(labelText: "password"),
          ),
          const SizedBox(height: Dimensions.DIVIDER_SIZE_SMALL),
          error != ''
              ? Text(
                  error!,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: colorScheme.secondary,
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: Dimensions.DIVIDER_SIZE_DOUBLE),
          ElevatedButton(
            onPressed: isLogin
                ? signInWithEmailAndPassword
                : createUserWithEmailAndPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.DIVIDER_SIZE_DOUBLE,
                  vertical: Dimensions.DIVIDER_SIZE_SMALL),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isLogin ? 'Login' : 'Register',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                isLogin = !isLogin;
              })
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.DIVIDER_SIZE_DOUBLE,
                  vertical: Dimensions.DIVIDER_SIZE_SMALL),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isLogin
                  ? 'Don\'t have an account? Sign up'
                  : 'Have an account? Login',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
