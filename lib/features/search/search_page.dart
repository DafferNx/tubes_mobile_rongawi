import 'package:flutter/material.dart';

import '../../core/widgets/category_chip.dart';
import '../../core/widgets/food_card.dart';
import '../../data/dummy_restaurants.dart';
import '../profile/edit_profile_page.dart';
import 'filter_bottom_sheet.dart';

class SearchPage extends StatefulWidget {
  final String initialCategory;

  const SearchPage({super.key, this.initialCategory = 'Semua'});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  late String selectedCategory;
  String selectedLocation = 'Semua Lokasi';
  double selectedRating = 0.0;

  final List<String> topSearches = [
    'Seblak Mercon',
    'Cuanki Serayu',
    'Kopi Toko Djawa',
    'Mie Ayam',
    'Nasi Ibu Imas',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Restaurant> getFilteredRestaurants() {
    final query = searchController.text.toLowerCase();

    return dummyRestaurants.where((item) {
      final cocokNama = item.name.toLowerCase().contains(query);
      final cocokKategori =
          selectedCategory == 'Semua' || item.category == selectedCategory;
      final cocokLokasi =
          selectedLocation == 'Semua Lokasi' ||
          item.location == selectedLocation;
      final cocokRating = item.rating >= selectedRating;

      return cocokNama && cocokKategori && cocokLokasi && cocokRating;
    }).toList();
  }

  void bukaFilter() async {
    final isDark = UserProfileData.isDarkMode;
    final hasilFilter = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(
        initialCategory: selectedCategory,
        initialLocation: selectedLocation,
        initialRating: selectedRating,
      ),
    );

    if (hasilFilter != null) {
      setState(() {
        selectedCategory = hasilFilter['category'] ?? 'Semua';
        selectedLocation = hasilFilter['location'] ?? 'Semua Lokasi';
        selectedRating = hasilFilter['rating'] ?? 0.0;
      });
    }
  }

  void resetPencarian() {
    setState(() {
      searchController.clear();
      selectedCategory = 'Semua';
      selectedLocation = 'Semua Lokasi';
      selectedRating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasilPencarian = getFilteredRestaurants();
    final bisaKembali = Navigator.canPop(context);
    final isDark = UserProfileData.isDarkMode;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final chipBg = isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
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
              // 1. Baris Search Bar Atas (Sesuai Referensi Desain Layar Kanan)
              Row(
                children: [
                  if (bisaKembali) ...[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: chipBg,
                        child: Icon(
                          Icons.chevron_left,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: chipBg,
                        borderRadius: BorderRadius.circular(24),
                        border: isDark ? Border.all(color: borderColor) : null,
                      ),
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: textColor, fontSize: 13),
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: UserProfileData.tr(
                            'Cari kuliner Bandung...',
                            'Search Bandung culinary...',
                            'Milari kuliner Bandung...',
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDark ? Colors.grey : Colors.black54,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: bukaFilter,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: isDark
                          ? Colors.orange.withValues(alpha: 0.15)
                          : Colors.orange.shade50,
                      child: const Icon(
                        Icons.tune,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // 2. Section Kategori (Wrap Chip Bergambar - Sesuai "Category" di Referensi)
              Text(
                UserProfileData.tr('Kategori', 'Categories', 'Kategori'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: kategoriKuliner.map((kategori) {
                  return CategoryChip(
                    label: kategori,
                    isSelected: selectedCategory == kategori,
                    onTap: () {
                      setState(() {
                        selectedCategory = kategori;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),

              // 3. Section Pencarian Populer (Sesuai "Top Searches" di Referensi)
              Text(
                UserProfileData.tr(
                  'Pencarian Populer',
                  'Top Searches',
                  'Pilarian Populér',
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: topSearches.map((kata) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        searchController.text = kata;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: chipBg,
                        borderRadius: BorderRadius.circular(20),
                        border: isDark ? Border.all(color: borderColor) : null,
                      ),
                      child: Text(
                        kata,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 4. Header Hasil Pencarian / Kuliner Populer (Sesuai "Popular products")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${UserProfileData.tr('Kuliner Populer', 'Popular Culinary', 'Kuliner Populér')} (${hasilPencarian.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: resetPencarian,
                    child: Row(
                      children: [
                        Text(
                          UserProfileData.tr(
                            'Lihat Semua',
                            'See All',
                            'Tingali Sadaya',
                          ),
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.orange,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 5. Grid Hasil Pencarian atau Empty State (Sesuai Referensi)
              if (hasilPencarian.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.orange.withValues(alpha: 0.15)
                                : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.search_off,
                            size: 40,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          UserProfileData.tr(
                            'Kuliner tidak ditemukan',
                            'No culinary spots found',
                            'Kuliner teu kapanggih',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          UserProfileData.tr(
                            'Coba gunakan kata kunci atau filter lain.',
                            'Try using different keywords or filters.',
                            'Cobi nganggo kecap konci atanapi saringan sanés.',
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: hasilPencarian.length,
                  itemBuilder: (context, index) {
                    return FoodCard(restaurant: hasilPencarian[index]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
