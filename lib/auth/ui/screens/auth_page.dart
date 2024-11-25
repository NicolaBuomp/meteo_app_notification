// lib/auth/ui/screens/auth_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benvenuto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Per continuare, effettua il login o registrati'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/auth/login');
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/auth/register');
              },
              child: const Text('Registrati'),
            ),
          ],
        ),
      ),
    );
  }
}
