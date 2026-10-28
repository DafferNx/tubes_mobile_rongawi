import 'package:flutter/material.dart';

/// Placeholder Halaman Favorite (Bagian Orang 4)
/// Terhubung pada tab Favorite di BottomNavigationBar (MainScaffold)
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kuliner Favorit')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halaman Favorite\n(Bagian Orang 4 — Dikosongkan sementara)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
