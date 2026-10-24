import 'package:flutter/material.dart';

import '../../data/restaurant_data.dart';

class FoodCard extends StatelessWidget {
  final Restaurant restaurant;
  const FoodCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  restaurant.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(' ${restaurant.rating} • ${restaurant.category}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.priceRange,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 14),
                    Text(
                      restaurant.distance,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
