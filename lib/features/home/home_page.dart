import 'package:flutter/material.dart';

import '../../core/widgets/food_card.dart';
import '../../data/dummy_restaurants.dart';
import '../search/filter_page.dart';
import '../search/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Semua';

  List<Restaurant> get filteredRestaurants {
    if (selectedCategory == 'Semua') {
      return dummyRestaurants;
    }
    return dummyRestaurants
        .where((item) => item.category == selectedCategory)
        .toList();
  }

  IconData getCategoryIcon(String category) {
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

  Color getCategoryPastelColor(String category) {
    switch (category) {
      case 'Seblak':
        return Colors.red.shade50;
      case 'Bakso':
        return Colors.amber.shade50;
      case 'Mie Ayam':
        return Colors.purple.shade50;
      case 'Cafe':
        return Colors.brown.shade50;
      case 'Sunda':
        return Colors.teal.shade50;
      default:
        return Colors.orange.shade50;
    }
  }

  Color getCategoryIconColor(String category) {
    switch (category) {
      case 'Seblak':
        return Colors.red;
      case 'Bakso':
        return Colors.amber.shade800;
      case 'Mie Ayam':
        return Colors.purple;
      case 'Cafe':
        return Colors.brown;
      case 'Sunda':
        return Colors.teal;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final daftarKuliner = filteredRestaurants;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Lokasi Bandung (Sesuai Referensi Desain)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lokasi Kuliner',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.orange,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Bandung, Jawa Barat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down, size: 18),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Banner Info/Rekomendasi Warna Orange (Sesuai Referensi Desain)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.restaurant_menu,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Temukan rekomendasi kuliner populer di Bandung!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Eksplor',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. Search Bar dengan Tombol Filter di Kanan (Sesuai Referensi Desain)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 20),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Cari seblak, bakso, mie ayam, cafe...',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FilterPage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.tune,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 4. Section Kategori dengan Kotak Pastel (Sesuai Referensi Desain)
              _buildSectionHeader(
                title: 'Kategori',
                onTapViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: kategoriKuliner.map((category) {
                    final isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.orange
                                    : getCategoryPastelColor(category),
                                borderRadius: BorderRadius.circular(16),
                                border: isSelected
                                    ? Border.all(
                                        color: Colors.orange.shade700,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Icon(
                                getCategoryIcon(category),
                                color: isSelected
                                    ? Colors.white
                                    : getCategoryIconColor(category),
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.orange
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // 5. Section Tempat Populer (Horizontal ListView - Sesuai "Best Selling Items")
              _buildSectionHeader(
                title: 'Tempat Populer',
                onTapViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchPage(initialCategory: selectedCategory),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyRestaurants.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 165,
                      margin: const EdgeInsets.only(right: 12),
                      child: FoodCard(restaurant: dummyRestaurants[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // 6. Section Rekomendasi Kuliner (Grid 2 Kolom)
              _buildSectionHeader(
                title: selectedCategory == 'Semua'
                    ? 'Rekomendasi Kuliner'
                    : 'Rekomendasi $selectedCategory',
                onTapViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchPage(initialCategory: selectedCategory),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: daftarKuliner.length,
                itemBuilder: (context, index) {
                  return FoodCard(restaurant: daftarKuliner[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTapViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTapViewAll,
          child: Row(
            children: const [
              Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2),
              Icon(Icons.chevron_right, color: Colors.orange, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
