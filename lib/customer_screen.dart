import 'package:flutter/material.dart';
import 'package:egaz/auth_service.dart';
import 'package:egaz/login_screen.dart';

final AuthService _authService = AuthService();

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: const Text('Espace Client'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenue cher client'),
            ElevatedButton(
              onPressed: () {
                _authService.signOut();
                print("Déconnexion");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("Déconnexion"),
            ),
          ],
        ),
      ),
    );
  }
}