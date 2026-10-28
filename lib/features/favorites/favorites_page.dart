import 'package:flutter/material.dart';

import '../profile/edit_profile_page.dart';

/// Placeholder Halaman Favorite (Bagian Orang 4)
/// Terhubung pada tab Favorite di BottomNavigationBar (MainScaffold)
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = UserProfileData.isDarkMode;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          UserProfileData.tr(
            'Kuliner Favorit',
            'Favorite Culinary',
            'Kuliner Karesep',
          ),
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            UserProfileData.tr(
              'Halaman Favorite\n(Bagian Orang 4 — Dikosongkan sementara)',
              'Favorites Page\n(Person 4 Section — Temporarily Empty)',
              'Kaca Karesep\n(Bagian Jalmi 4 — Dikosongkeun saheulaanan)',
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
