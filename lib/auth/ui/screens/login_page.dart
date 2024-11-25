// lib/auth/ui/screens/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/auth/viewmodel/auth_state.dart';
import 'package:meteo_app_notification/base/router/router.dart';
import '../../di/auth_provider.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final emailController =
      TextEditingController(text: 'nicolabuompane@icloud.com');
  final passwordController = TextEditingController(text: 'developer123');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.isAuthenticated) {
        // Se l'utente è autenticato, reindirizza alla pagina principale
        context.go(Routes.weatherPage);
      } else if (next.error != null) {
        // Mostra un messaggio di errore
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (authState.error != null)
                    Text(
                      authState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      authViewModel.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                    child: const Text('Accedi'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/auth/register');
                    },
                    child: const Text('Non hai un account? Registrati'),
                  ),
                ],
              ),
            ),
    );
  }
}
