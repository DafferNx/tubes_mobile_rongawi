import 'package:flutter/material.dart';

import '../../core/widgets/food_card.dart';
import '../../data/restaurant_data.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Bandung Foodies',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo, Foodies!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Seblak', 'Bakso', 'Mie Ayam', 'Cafe'].map((category) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      radius: 25,
                      child: const Icon(Icons.fastfood, color: Colors.orange),
                    ),
                    const SizedBox(height: 4),
                    Text(category, style: const TextStyle(fontSize: 12)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              child: const Text(
                'Promo menarik di Bandung\nRekomendasi Kuliner Akhir Pekan!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Rekomendasi/Populer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: dataRestaurant.length,
              itemBuilder: (context, index) =>
                  FoodCard(restaurant: dataRestaurant[index]),
            ),
          ],
        ),
      ),
    );
  }
}
