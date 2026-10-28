import 'package:flutter/material.dart';

/// Placeholder Halaman Register (Bagian Orang 5)
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halaman Register\n(Bagian Orang 5 — Dikosongkan sementara)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
