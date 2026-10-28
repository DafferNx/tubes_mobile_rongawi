import 'package:flutter/material.dart';

import 'filter_bottom_sheet.dart';

class FilterPage extends StatelessWidget {
  final String initialCategory;
  final String initialLocation;
  final double initialRating;

  const FilterPage({
    super.key,
    this.initialCategory = 'Semua',
    this.initialLocation = 'Semua Lokasi',
    this.initialRating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: const Icon(Icons.chevron_left, color: Colors.black87),
            ),
          ),
        ),
        title: const Text(
          'Filter Kuliner',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: FilterBottomSheet(
        initialCategory: initialCategory,
        initialLocation: initialLocation,
        initialRating: initialRating,
      ),
    );
  }
}
