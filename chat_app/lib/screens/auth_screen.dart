import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: AuthForm(),
            ),
          ),
        ),
      ),
    );
  }
}
