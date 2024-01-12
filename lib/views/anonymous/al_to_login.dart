import 'package:flutter/material.dart';
import 'package:spa_app/views/login_page.dart';
import 'package:spa_app/views/signup_page.dart';

class ToLoginDialog extends StatelessWidget {
  const ToLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Widget loginButton = TextButton(
      child: Text("Log In"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
    Widget signupButton = TextButton(
      child: Text("Sign Up"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpPage(),
          ),
        );
      },
    );
    return AlertDialog(
      title: Text("Treatment Detail"),
      content:
          Text("You must login first or sign up if you don't have an account."),
      actions: [loginButton, signupButton],
    );
  }
}
