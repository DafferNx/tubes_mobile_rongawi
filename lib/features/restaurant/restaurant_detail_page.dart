import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../profile/edit_profile_page.dart';

/// Placeholder Halaman Detail Restoran (Bagian Orang 2)
/// Menerima pengiriman data Restaurant dari Home / Search (Modul 7.2.2)
class RestaurantDetailPage extends StatelessWidget {
  final Restaurant? restaurant;

  const RestaurantDetailPage({super.key, this.restaurant});

  @override
  Widget build(BuildContext context) {
    final item = restaurant ?? dummyRestaurants.first;
    final isDark = UserProfileData.isDarkMode;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(item.name, style: TextStyle(color: textColor)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.restaurant, size: 60, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                item.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${item.category} • ${item.location} • ⭐ ${item.rating}',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 4),
              Text(
                item.priceRange,
                style: const TextStyle(color: Colors.orange),
              ),
              const SizedBox(height: 20),
              Text(
                UserProfileData.tr(
                  'Halaman Detail Restoran\n(Bagian Orang 2 - Dikosongkan sementara)',
                  'Restaurant Detail Page\n(Person 2 Section - Temporarily Empty)',
                  'Kaca Détail Réstoran\n(Bagian Jalmi 2 - Dikosongkeun saheulaanan)',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  UserProfileData.tr('Kembali', 'Back', 'Mulih'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
