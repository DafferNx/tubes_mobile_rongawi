import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../features/restaurant/restaurant_detail_page.dart';

class FoodCard extends StatefulWidget {
  final Restaurant restaurant;

  const FoodCard({super.key, required this.restaurant});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.restaurant;

    return GestureDetector(
      onTap: () {
        // Navigasi Mengirim Data ke Detail Restoran (Bagian Orang 2) - Modul 7
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailPage(restaurant: item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Makanan dengan Sudut Membulat (Modul 4.3)
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      color: Colors.orange.shade50,
                      child: const Center(
                        child: Icon(
                          Icons.fastfood,
                          size: 36,
                          color: Colors.orange,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Nama Tempat Makan
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),

            // Rating & Kategori/Lokasi
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 15),
                const SizedBox(width: 4),
                Text(
                  '${item.rating}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '(${item.location} • ${item.distance})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Baris Bawah: Harga di Kiri & Tombol Bulat Orange di Kanan (Sesuai Referensi)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.priceRange,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
