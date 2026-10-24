import 'package:flutter/material.dart';
import 'package:tubes_mobile_rongawi/data/restaurant_data.dart';

import '../../core/widgets/food_card.dart';
import '../../data/restaurant_data.dart';
import 'filter_bottom_sheet.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Cari kuliner Bandung...',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => FilterBottomSheet(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Pencarian Populer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Wrap(
            spacing: 8,
            children: [
              'Seblak Mercon',
              'Cuanki',
              'Kopi Bandung',
            ].map((e) => Chip(label: Text(e))).toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            'Hasil Pencarian',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataRestaurant.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: FoodCard(restaurant: dataRestaurant[index]),
            ),
          ),
        ],
      ),
    );
  }
}
