import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.account_circle),
              label: const Text('Create a new account'),
              onPressed: () async {
                context.go('/login/create');
              },
            ),
            Padding(
              padding: EdgeInsets.all(15),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Sign in to an existing account'),
              onPressed: () async {
                context.go('/login/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
