class Restaurant {
  final String name;
  final String category;
  final String priceRange;
  final String location;
  final String distance;
  final double rating;
  final String imageUrl;
  final String address;
  final String openHours;
  final String description;

  const Restaurant({
    required this.name,
    required this.category,
    required this.priceRange,
    required this.location,
    required this.distance,
    required this.rating,
    required this.imageUrl,
    this.address = 'Bandung, Jawa Barat',
    this.openHours = '10.00 - 22.00 WIB',
    this.description = 'Tempat makan rekomendasi di kawasan Bandung.',
  });
}

final List<String> kategoriKuliner = [
  'Semua',
  'Seblak',
  'Bakso',
  'Mie Ayam',
  'Cafe',
  'Sunda',
];

final List<String> lokasiBandung = [
  'Semua Lokasi',
  'Dago',
  'Braga',
  'Dipatiukur',
  'Buahbatu',
  'Lembang',
];

final List<Restaurant> dummyRestaurants = [
  const Restaurant(
    name: 'Seblak Mercon Bandung',
    category: 'Seblak',
    priceRange: 'Rp15rb - Rp30rb',
    location: 'Dago',
    distance: '1.2 km',
    rating: 4.8,
    imageUrl: 'https://picsum.photos/id/292/400/300',
    address: 'Jl. Ir. H. Juanda No. 112, Dago, Bandung',
    openHours: '10.00 - 22.00 WIB',
    description:
        'Seblak khas Bandung dengan kuah kencur pedas dan pilihan topping lengkap.',
  ),
  const Restaurant(
    name: 'Bakso Cuanki Serayu',
    category: 'Bakso',
    priceRange: 'Rp15rb - Rp28rb',
    location: 'Braga',
    distance: '1.8 km',
    rating: 4.9,
    imageUrl: 'https://picsum.photos/id/488/400/300',
    address: 'Jl. Serayu No. 2, Cihapit, Bandung',
    openHours: '11.00 - 19.00 WIB',
    description:
        'Bakso cuanki legendaris di Bandung dengan kuah kaldu gurih dan batagor renyah.',
  ),
  const Restaurant(
    name: 'Kopi Toko Djawa',
    category: 'Cafe',
    priceRange: 'Rp20rb - Rp45rb',
    location: 'Braga',
    distance: '2.4 km',
    rating: 4.7,
    imageUrl: 'https://picsum.photos/id/425/400/300',
    address: 'Jl. Braga No. 81, Braga, Bandung',
    openHours: '08.00 - 22.00 WIB',
    description:
        'Kedai kopi populer di Jalan Braga dengan suasana klasik dan es kopi susu gula aren.',
  ),
  const Restaurant(
    name: 'Mie Ayam Cipaganti',
    category: 'Mie Ayam',
    priceRange: 'Rp15rb - Rp25rb',
    location: 'Dipatiukur',
    distance: '2.0 km',
    rating: 4.6,
    imageUrl: 'https://picsum.photos/id/493/400/300',
    address: 'Jl. Cipaganti No. 85, Bandung',
    openHours: '08.00 - 17.00 WIB',
    description:
        'Mie yamin manis dan asin khas Bandung lengkap dengan pangsit rebus dan bakso.',
  ),
  const Restaurant(
    name: 'Warung Nasi Ibu Imas',
    category: 'Sunda',
    priceRange: 'Rp25rb - Rp50rb',
    location: 'Buahbatu',
    distance: '3.1 km',
    rating: 4.8,
    imageUrl: 'https://picsum.photos/id/429/400/300',
    address: 'Jl. Balonggede No. 67, Bandung',
    openHours: '07.00 - 23.00 WIB',
    description:
        'Rumah makan Sunda populer dengan ayam bakar, karedok leunca, dan sambal dadak.',
  ),
  const Restaurant(
    name: 'Sejiwa Coffee',
    category: 'Cafe',
    priceRange: 'Rp25rb - Rp55rb',
    location: 'Dipatiukur',
    distance: '0.9 km',
    rating: 4.5,
    imageUrl: 'https://picsum.photos/id/431/400/300',
    address: 'Jl. Progo No. 15, Bandung',
    openHours: '07.00 - 23.00 WIB',
    description:
        'Tempat nongkrong nyaman di Bandung dengan kopi spesialti dan berbagai pastry.',
  ),
];

// Alias untuk menjaga kompatibilitas nama variabel
final List<Restaurant> dataRestaurant = dummyRestaurants;
