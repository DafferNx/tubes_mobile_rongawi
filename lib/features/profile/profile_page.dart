import 'package:flutter/material.dart';

/// Placeholder Halaman Profile & Edit Profile (Bagian Orang 5)
/// Terhubung pada tab Profile di BottomNavigationBar (MainScaffold)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halaman Profile & Edit Profile\n(Bagian Orang 5 — Dikosongkan sementara)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
