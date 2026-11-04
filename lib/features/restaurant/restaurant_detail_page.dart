import 'package:flutter/material.dart';

import 'menu_detail_page.dart';
import '../../data/dummy_restaurants.dart';
import '../../core/widgets/route_choices.dart';
import '../../navigation/main_scaffold.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant? restaurant;

  const RestaurantDetailPage({super.key, this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool isFavorite = false;

  final List<String> galleryImages = const [
    'assets/images/image_03.jpg',
    'assets/images/image_01.jpg',
    'assets/images/image_02.jpg',
  ];

  // Daftar menu dengan atribut spesifik (kalori, waktu, level, kategori)
  final List<Map<String, dynamic>> menuList = const [
    {
      'name': 'Seblak Komplit Special',
      'price': 'Rp 25.000',
      'image': 'assets/images/image_05.jpg',
      'description':
          'Seblak dengan isian kerupuk, bakso, sosis, ceker, dan telur.',
      'calories': '450 Kalori',
      'prepTime': '15 Menit',
      'spicyLevel': 'Pedas Level 3',
      'category': 'Makanan Utama',
      'isFavorite': true,
    },
    {
      'name': 'Mie Ayam Bakso Spesial',
      'price': 'Rp 20.000',
      'image': 'assets/images/image_06.jpg',
      'description':
          'Mie kenyal dengan cincangan ayam gurih dan bakso sapi asli.',
      'calories': '400 Kalori',
      'prepTime': '12 Menit',
      'category': 'Makanan Utama',
      'isFavorite': true,
    },
    {
      'name': 'Es Teh Manis',
      'price': 'Rp 5.000',
      'image': 'assets/images/image_04.jpg',
      'description': 'Minuman es teh segar manis alami.',
      'calories': '90 Kalori',
      'prepTime': '5 Menit',
      'category': 'Minuman',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final place = widget.restaurant ?? dummyRestaurants.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restoran'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 112),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: galleryImages.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    galleryImages[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${place.rating}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Text(
                        '◷ ${place.openHours}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        place.priceRange,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          place.address,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RouteChoices(
                    restaurant: place,
                    onRoute: () => MainScaffold.showRoute(context, place),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Daftar Menu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuList.length,
                    itemBuilder: (context, index) {
                      final item = menuList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['price']!),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuDetailPage(
                                  name: item['name']!,
                                  price: item['price']!,
                                  image: item['image']!,
                                  description: item['description']!,
                                  calories: item['calories'],
                                  prepTime: item['prepTime'],
                                  category: item['category'],
                                  spicyLevel: item['spicyLevel'],
                                  isFavorite: item['isFavorite'] ?? false,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
