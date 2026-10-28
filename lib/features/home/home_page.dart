import 'package:flutter/material.dart';

import '../../core/widgets/food_card.dart';
import '../../data/dummy_restaurants.dart';
import '../profile/edit_profile_page.dart';
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

  Color getCategoryPastelColor(String category, bool isDark) {
    if (isDark) {
      return const Color(0xFF1E1E1E);
    }
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

  String _translateCategory(String category) {
    if (category == 'Semua') {
      return UserProfileData.tr('Semua', 'All', 'Sadaya');
    }
    return category;
  }

  @override
  Widget build(BuildContext context) {
    final daftarKuliner = filteredRestaurants;
    final isDark = UserProfileData.isDarkMode;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final searchBg = isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 105.0),
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
                      Text(
                        UserProfileData.tr(
                          'Lokasi Kuliner',
                          'Culinary Location',
                          'Lokasi Kuliner',
                        ),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            UserProfileData.tr(
                              'Bandung, Jawa Barat',
                              'Bandung, West Java',
                              'Bandung, Jawa Kulon',
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: textColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        size: 20,
                        color: textColor,
                      ),
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
                    Expanded(
                      child: Text(
                        UserProfileData.tr(
                          'Temukan rekomendasi kuliner populer di Bandung!',
                          'Discover popular culinary spots in Bandung!',
                          'Panggihan rekomendasi kuliner populér di Bandung!',
                        ),
                        style: const TextStyle(
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
                        child: Text(
                          UserProfileData.tr('Eksplor', 'Explore', 'Éksplor'),
                          style: const TextStyle(
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
                    color: searchBg,
                    borderRadius: BorderRadius.circular(12),
                    border: isDark ? Border.all(color: borderColor) : null,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          UserProfileData.tr(
                            'Cari seblak, bakso, mie ayam, cafe...',
                            'Search seblak, bakso, chicken noodles, cafe...',
                            'Milari seblak, baso, mie ayam, cafe...',
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
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
                        child: Icon(
                          Icons.tune,
                          color: textColor,
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
                title: UserProfileData.tr('Kategori', 'Categories', 'Kategori'),
                textColor: textColor,
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
                                    : getCategoryPastelColor(category, isDark),
                                borderRadius: BorderRadius.circular(16),
                                border: isSelected
                                    ? Border.all(
                                        color: Colors.orange.shade700,
                                        width: 2,
                                      )
                                    : (isDark
                                          ? Border.all(color: borderColor)
                                          : null),
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
                              _translateCategory(category),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected ? Colors.orange : textColor,
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
                title: UserProfileData.tr(
                  'Tempat Populer',
                  'Popular Spots',
                  'Tempat Populér',
                ),
                textColor: textColor,
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
                    ? UserProfileData.tr(
                        'Rekomendasi Kuliner',
                        'Culinary Recommendations',
                        'Rekomendasi Kuliner',
                      )
                    : '${UserProfileData.tr('Rekomendasi', 'Recommended', 'Rekomendasi')} $selectedCategory',
                textColor: textColor,
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
    required Color textColor,
    required VoidCallback onTapViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        GestureDetector(
          onTap: onTapViewAll,
          child: Row(
            children: [
              Text(
                UserProfileData.tr('Lihat Semua', 'See All', 'Tingali Sadaya'),
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right, color: Colors.orange, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
