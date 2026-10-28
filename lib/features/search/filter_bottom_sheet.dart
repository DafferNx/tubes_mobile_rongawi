import 'package:flutter/material.dart';

import '../../core/widgets/category_chip.dart';
import '../../data/dummy_restaurants.dart';

class FilterBottomSheet extends StatefulWidget {
  final String initialCategory;
  final String initialLocation;
  final double initialRating;

  const FilterBottomSheet({
    super.key,
    this.initialCategory = 'Semua',
    this.initialLocation = 'Semua Lokasi',
    this.initialRating = 0.0,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String selectedCategory;
  late String selectedLocation;
  late double selectedRating;
  RangeValues priceRange = const RangeValues(15000, 50000);

  final List<double> ratingList = [0.0, 4.0, 4.5, 4.8];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    selectedLocation = widget.initialLocation;
    selectedRating = widget.initialRating;
  }

  void resetFilter() {
    setState(() {
      selectedCategory = 'Semua';
      selectedLocation = 'Semua Lokasi';
      selectedRating = 0.0;
      priceRange = const RangeValues(15000, 50000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Filter & Tombol Reset
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Pencarian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: resetFilter,
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 1. Filter Kategori Makanan
          const Text(
            'Kategori Makanan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
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
          const SizedBox(height: 16),

          // 2. Filter Lokasi Bandung (Menggunakan DropdownButton - Modul 6.2.4.3)
          const Text(
            'Lokasi di Bandung',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: selectedLocation,
              isExpanded: true,
              underline: const SizedBox(),
              items: lokasiBandung.map((lokasi) {
                return DropdownMenuItem<String>(
                  value: lokasi,
                  child: Text(lokasi),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 16),

          // 3. Filter Rentang Harga
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rentang Harga',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Rp${(priceRange.start / 1000).round()}rb - Rp${(priceRange.end / 1000).round()}rb',
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: priceRange,
            min: 10000,
            max: 100000,
            divisions: 9,
            activeColor: Colors.orange,
            onChanged: (RangeValues values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Murah (Rp10rb)', style: TextStyle(fontSize: 12)),
              Text('Mahal (Rp100rb)', style: TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),

          // 4. Filter Rating
          const Text(
            'Rating Minimum',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ratingList.map((rating) {
              final label = rating == 0.0 ? 'Semua' : '⭐ $rating+';
              final isSelected = selectedRating == rating;
              return ChoiceChip(
                label: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
                selected: isSelected,
                selectedColor: Colors.orange,
                onSelected: (_) {
                  setState(() {
                    selectedRating = rating;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Tombol Terapkan Filter (Mengirim balik data dengan Navigator.pop - Modul 7.2)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  'category': selectedCategory,
                  'location': selectedLocation,
                  'rating': selectedRating,
                });
              },
              child: const Text(
                'Terapkan Filter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
