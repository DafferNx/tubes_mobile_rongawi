import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../core/widgets/route_choices.dart';
import '../../navigation/main_scaffold.dart';
import '../community/demo_pages.dart';

class LocationDetailPage extends StatelessWidget {
  final Restaurant? restaurant;
  const LocationDetailPage({super.key, this.restaurant});
  @override
  Widget build(BuildContext context) {
    final item = restaurant ?? dummyRestaurants.first;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail tempat makan')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 112),
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2E6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              size: 64,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            item.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('${item.category} • ★ ${item.rating}'),
          const SizedBox(height: 16),
          Text(item.description),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Alamat'),
                  subtitle: Text(item.address),
                ),
                ListTile(
                  leading: const Icon(Icons.schedule),
                  title: const Text('Jam buka'),
                  subtitle: Text(item.openHours),
                ),
                ListTile(
                  leading: const Icon(Icons.payments_outlined),
                  title: const Text('Kisaran harga'),
                  subtitle: Text(item.priceRange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RouteChoices(
            restaurant: item,
            onRoute: () => MainScaffold.showRoute(context, item),
          ),
          OutlinedButton.icon(
            onPressed: () => showSuccess(
              context,
              '${item.name} berhasil ditambahkan ke favorit.',
            ),
            icon: const Icon(Icons.favorite_border),
            label: const Text('Simpan ke favorit'),
          ),
        ],
      ),
    );
  }
}
