import 'package:flutter/material.dart';

import '../profile/edit_profile_page.dart';
import 'filter_bottom_sheet.dart';

class FilterPage extends StatelessWidget {
  final String initialCategory;
  final String initialLocation;
  final double initialRating;

  const FilterPage({
    super.key,
    this.initialCategory = 'Semua',
    this.initialLocation = 'Semua Lokasi',
    this.initialRating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = UserProfileData.isDarkMode;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final btnBg = isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: btnBg,
              child: Icon(Icons.chevron_left, color: textColor),
            ),
          ),
        ),
        title: Text(
          UserProfileData.tr(
            'Filter Kuliner',
            'Culinary Filter',
            'Filter Kuliner',
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
      body: FilterBottomSheet(
        initialCategory: initialCategory,
        initialLocation: initialLocation,
        initialRating: initialRating,
      ),
    );
  }
}
