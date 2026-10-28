import 'package:flutter/material.dart';

/// Placeholder Halaman Detail Menu (Bagian Orang 2)
class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Menu')),
      body: const Center(
        child: Text(
          'Halaman Detail Menu\n(Bagian Orang 2 - Dikosongkan sementara)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
