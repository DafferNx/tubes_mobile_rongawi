import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';

/// Placeholder Halaman Detail Restoran (Bagian Orang 2)
/// Menerima pengiriman data Restaurant dari Home / Search (Modul 7.2.2)
class RestaurantDetailPage extends StatelessWidget {
  final Restaurant? restaurant;

  const RestaurantDetailPage({super.key, this.restaurant});

  @override
  Widget build(BuildContext context) {
    final item = restaurant ?? dummyRestaurants.first;

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('${item.category} • ${item.location} • ⭐ ${item.rating}'),
              const SizedBox(height: 4),
              Text(
                item.priceRange,
                style: const TextStyle(color: Colors.orange),
              ),
              const SizedBox(height: 20),
              const Text(
                'Halaman Detail Restoran\n(Bagian Orang 2 - Dikosongkan sementara)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
