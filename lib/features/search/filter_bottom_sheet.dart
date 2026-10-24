import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(10000, 50000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Pencarian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: ['Seblak', 'Bakso', 'Mie Ayam', 'Cafe']
                .map(
                  (e) => ChoiceChip(
                    label: Text(e),
                    selected: e == 'Seblak',
                    selectedColor: Colors.orange,
                    onSelected: (val) {},
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('Harga', style: TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 100000,
            activeColor: Colors.orange,
            onChanged: (RangeValues values) {
              setState(() => _priceRange = values);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('Murah'), Text('Mahal')],
          ),
          const SizedBox(height: 16),
          const Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: ['1+', '2+', '3+', '4+', '4+']
                .map(
                  (e) => ChoiceChip(
                    label: Text(e),
                    selected: e == '4+',
                    selectedColor: Colors.orange,
                    onSelected: (val) {},
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Terapkan Filter',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
