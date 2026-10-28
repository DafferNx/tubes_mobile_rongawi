import 'package:flutter/material.dart';

import '../../features/profile/edit_profile_page.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getIcon(String category) {
    switch (category) {
      case 'Seblak':
        return Icons.local_fire_department;
      case 'Bakso':
        return Icons.soup_kitchen;
      case 'Mie Ayam':
        return Icons.ramen_dining;
      case 'Cafe':
        return Icons.local_cafe;
      case 'Sunda':
        return Icons.rice_bowl;
      default:
        return Icons.restaurant_menu;
    }
  }

  String _translateCategory(String category) {
    if (category == 'Semua') {
      return UserProfileData.tr('Semua', 'All', 'Sadaya');
    }
    return category;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = UserProfileData.isDarkMode;
    final unselectedBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final unselectedBorder =
        isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final unselectedText = isDark ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : unselectedBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.orange : unselectedBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(label),
              size: 16,
              color: isSelected ? Colors.white : Colors.orange,
            ),
            const SizedBox(width: 6),
            Text(
              _translateCategory(label),
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : unselectedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
