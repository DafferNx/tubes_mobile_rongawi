class Restaurant {
  final String name, category, priceRange, distance, imageUrl;
  final double rating;

  Restaurant({
    required this.name,
    required this.category,
    required this.priceRange,
    required this.distance,
    required this.rating,
    required this.imageUrl,
  });
}

final List<Restaurant> dataRestaurant = [
  Restaurant(
    name: 'Seblak Mercon Bandung',
    category: 'Kuliner',
    priceRange: 'Rp15rb - Rp30rb',
    distance: '1.2 km',
    rating: 4.8,
    imageUrl: 'https://picsum.photos/200',
  ),
  Restaurant(
    name: 'Bakso Cuanki',
    category: 'Kuliner',
    priceRange: 'Rp15rb - Rp30rb',
    distance: '1.2 km',
    rating: 4.8,
    imageUrl: 'https://picsum.photos/201',
  ),
];
