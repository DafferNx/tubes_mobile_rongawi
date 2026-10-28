import 'package:flutter/material.dart';

import '../../core/widgets/category_chip.dart';
import '../../core/widgets/food_card.dart';
import '../../data/dummy_restaurants.dart';
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
    final hasilFilter = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
                        backgroundColor: Colors.grey.shade100,
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Cari kuliner Bandung...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: bukaFilter,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.orange.shade50,
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
              const Text(
                'Kategori',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              const Text(
                'Pencarian Populer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        kata,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
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
                    'Kuliner Populer (${hasilPencarian.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: resetPencarian,
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
                        Icon(
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
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.search_off,
                            size: 40,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Kuliner tidak ditemukan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Coba gunakan kata kunci atau filter lain.',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
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
