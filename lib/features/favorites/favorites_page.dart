import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../restaurant/restaurant_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Kuliner favorit')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 112),
      children: [
        const Text(
          'Pilihan untuk dikunjungi lagi',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text('Koleksi tempat makan favorit kamu di Bandung.'),
        const SizedBox(height: 20),
        for (final item in dummyRestaurants.take(3))
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF2E6),
                child: Icon(Icons.restaurant, color: Colors.orange),
              ),
              title: Text(item.name),
              subtitle: Text(
                '${item.category} • ${item.location}\n${item.priceRange} • ★ ${item.rating}',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.favorite, color: Colors.orange),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => RestaurantDetailPage(restaurant: item),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
