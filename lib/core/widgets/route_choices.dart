import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../features/community/demo_pages.dart';

class RouteChoices extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onRoute;
  final String routeLabel;
  const RouteChoices({
    super.key,
    required this.restaurant,
    required this.onRoute,
    this.routeLabel = 'Lihat rute',
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilledButton.icon(
        onPressed: onRoute,
        icon: const Icon(Icons.directions_outlined),
        label: Text(routeLabel),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('atau'),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ),
      OutlinedButton.icon(
        onPressed: () => showSuccess(
          context,
          'Anda berhasil dialihkan ke Google Maps.\nTujuan: ${restaurant.name}.',
        ),
        icon: const Icon(Icons.open_in_new),
        label: const Text('Gunakan Google Maps'),
      ),
    ],
  );
}
