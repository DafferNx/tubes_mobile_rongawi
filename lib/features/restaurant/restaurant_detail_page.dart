import 'package:flutter/material.dart';
import 'menu_detail_page.dart';

class RestaurantDetailPage extends StatefulWidget {
  final dynamic restaurant;

  const RestaurantDetailPage({Key? key, this.restaurant}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool isFavorite = false;

  final List<String> galleryImages = const [
    'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500',
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500',
    'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=500',
  ];

  final List<Map<String, String>> menuList = const [
    {
      'name': 'Seblak Komplit Special',
      'price': 'Rp 25.000',
      'image': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
      'description': 'Seblak dengan isian kerupuk, bakso, sosis, ceker, dan telur.',
    },
    {
      'name': 'Mie Ayam Bakso Spesial',
      'price': 'Rp 20.000',
      'image': 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=500',
      'description': 'Mie kenyal dengan cincangan ayam gurih dan bakso sapi asli.',
    },
    {
      'name': 'Es Teh Manis',
      'price': 'Rp 5.000',
      'image': 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500',
      'description': 'Minuman es teh segar manis alami.',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: galleryImages.length,
                itemBuilder: (context, index) {
                  return Image.network(
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
                          widget.restaurant?.name ?? 'Warung Kuliner Bandung',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text('10.00 - 22.00 WIB', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 16),
                      Icon(Icons.monetization_on_outlined, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text('Rp 15.000 - Rp 50.000', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Jl. Ciumbuleuit No. 42, Bandung',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map),
                      label: const Text('Lihat Lokasi'),
                    ),
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
                            child: Image.network(
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
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuDetailPage(
                                  name: item['name']!,
                                  price: item['price']!,
                                  image: item['image']!,
                                  description: item['description']!,
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