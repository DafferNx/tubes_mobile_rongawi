import 'package:flutter/material.dart';

/// Placeholder Halaman Maps, Nearby, Direction Preview (Bagian Orang 3)
/// Terhubung pada tab Maps di BottomNavigationBar (MainScaffold)
class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peta Kuliner Bandung')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halaman Maps, Nearby & Direction Preview\n(Bagian Orang 3 — Dikosongkan sementara)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
