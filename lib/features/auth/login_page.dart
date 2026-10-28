import 'package:flutter/material.dart';

/// Placeholder Halaman Login (Bagian Orang 5)
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halaman Login\n(Bagian Orang 5 — Dikosongkan sementara)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
