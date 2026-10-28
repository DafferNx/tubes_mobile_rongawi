import 'package:flutter/material.dart';

import '../profile/edit_profile_page.dart';

/// Placeholder Halaman Review & Tulis Review (Bagian Orang 4)
class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

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
            'Review & Komentar',
            'Reviews & Comments',
            'Ulasan & Koméntar',
          ),
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            UserProfileData.tr(
              'Halaman Review & Tulis Review\n(Bagian Orang 4 — Dikosongkan sementara)',
              'Reviews & Write Review Page\n(Person 4 Section — Temporarily Empty)',
              'Kaca Ulasan & Tulis Ulasan\n(Bagian Jalmi 4 — Dikosongkeun saheulaanan)',
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
