import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../profile/edit_profile_page.dart';

// Palet halaman Maps: satu aksen, teks utama, dan teks pendukung.
const _accent = Color(0xFFEF6C00);
const _ink = Color(0xFF252B29);
const _muted = Color(0xFF6D7571);
const _soft = Color(0xFFFFF2E6);
const _line = Color(0xFFE5E9E6);

/// Peta dan rute ilustrasi: seluruh data lokal, tanpa API atau GPS.
class MapsPage extends StatefulWidget {
  const MapsPage({super.key});
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  String category = 'Semua', query = '', vehicle = 'Motor';
  bool nearby = false, direction = false, started = false;
  Restaurant selected = dummyRestaurants.first;

  bool get _isDark => UserProfileData.isDarkMode;
  String _tr(String id, String en, [String? su]) =>
      UserProfileData.tr(id, en, su);

  static const positions = [
    Offset(.64, .30),
    Offset(.25, .51),
    Offset(.73, .64),
    Offset(.28, .24),
    Offset(.44, .76),
    Offset(.80, .44),
  ];

  double distance(Restaurant item) =>
      double.parse(item.distance.split(' ').first);
  List<Restaurant> get places {
    final items = dummyRestaurants
        .where(
          (r) =>
              (category == 'Semua' || r.category == category) &&
              '${r.name} ${r.location}'.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    items.sort((a, b) => distance(a).compareTo(distance(b)));
    return items;
  }

  void preview(Restaurant item) => setState(() {
    selected = item;
    direction = true;
    nearby = false;
    started = false;
  });

  @override
  Widget build(BuildContext context) {
    final results = places;
    final bgColor = _isDark ? const Color(0xFF121212) : Colors.white;
    final cardColor = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDark ? Colors.white : _ink;
    final lineColor = _isDark ? Colors.grey.shade800 : _line;

    // Tema lokal agar halaman anggota lain tidak ikut berubah.
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: _isDark ? Brightness.dark : Brightness.light,
        ).copyWith(
          primary: _accent,
          onPrimary: Colors.white,
          surface: cardColor,
          onSurface: textColor,
          onSurfaceVariant: _muted,
          primaryContainer: _isDark
              ? Colors.orange.withValues(alpha: 0.2)
              : _soft,
          onPrimaryContainer: _accent,
          secondaryContainer: _isDark
              ? Colors.orange.withValues(alpha: 0.2)
              : _soft,
          onSecondaryContainer: _accent,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: cardColor,
          selectedColor: _isDark ? Colors.orange.withValues(alpha: 0.2) : _soft,
          side: BorderSide.none,
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          labelStyle: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final mapHeight =
                  (constraints.maxHeight * (direction ? .49 : .57)).clamp(
                    270.0,
                    470.0,
                  );
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: mapHeight,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _MapPainter(
                                destination:
                                    positions[dummyRestaurants.indexOf(
                                      selected,
                                    )],
                                showRoute: direction,
                                isDark: _isDark,
                              ),
                            ),
                          ),
                          ...dummyRestaurants
                              .asMap()
                              .entries
                              .where(
                                (e) => direction
                                    ? e.value == selected
                                    : results.contains(e.value),
                              )
                              .map(
                                (e) => Positioned(
                                  left:
                                      constraints.maxWidth *
                                          positions[e.key].dx -
                                      20,
                                  top:
                                      140 +
                                      (mapHeight - 190) * positions[e.key].dy -
                                      20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: .12,
                                          ),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: IconButton.filled(
                                      tooltip: e.value.name,
                                      style: IconButton.styleFrom(
                                        backgroundColor: e.value == selected
                                            ? _accent
                                            : cardColor,
                                        foregroundColor: e.value == selected
                                            ? Colors.white
                                            : _accent,
                                        side: BorderSide(
                                          color: cardColor,
                                          width: 3,
                                        ),
                                        minimumSize: const Size(40, 40),
                                      ),
                                      onPressed: () {
                                        if (!direction) {
                                          setState(() {
                                            selected = e.value;
                                            nearby = false;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        e.value.category == 'Cafe'
                                            ? Icons.local_cafe_outlined
                                            : Icons.restaurant_outlined,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          Positioned(
                            left: 16,
                            right: 16,
                            top: 12,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: .05,
                                        ),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        tooltip: direction
                                            ? _tr(
                                                'Kembali ke peta',
                                                'Back to map',
                                                'Mulih ka peta',
                                              )
                                            : _tr(
                                                'Lokasi Bandung',
                                                'Bandung Location',
                                                'Lokasi Bandung',
                                              ),
                                        onPressed: () {
                                          if (direction) {
                                            setState(() {
                                              direction = false;
                                              started = false;
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      _tr(
                                                        'Lokasi contoh: Bandung, Jawa Barat.',
                                                        'Sample location: Bandung, West Java.',
                                                        'Lokasi conto: Bandung, Jawa Kulon.',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                          }
                                        },
                                        icon: Icon(
                                          direction
                                              ? Icons.arrow_back
                                              : Icons.location_on_outlined,
                                          color: _accent,
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              direction
                                                  ? _tr(
                                                      'Petunjuk arah',
                                                      'Directions',
                                                      'Pituduh arah',
                                                    )
                                                  : _tr(
                                                      'Jelajah kuliner',
                                                      'Explore Culinary',
                                                      'Kotéktak Kuliner',
                                                    ),
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: textColor,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              _tr(
                                                'Bandung, Jawa Barat',
                                                'Bandung, West Java',
                                                'Bandung, Jawa Kulon',
                                              ),
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: _muted,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.explore_outlined,
                                          color: _muted,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!direction) ...[
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: TextField(
                                      onChanged: (v) =>
                                          setState(() => query = v),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: textColor,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: _tr(
                                          'Cari tempat atau kawasan...',
                                          'Search spots or areas...',
                                          'Milari tempat atanapi wewengkon...',
                                        ),
                                        hintStyle: const TextStyle(
                                          color: _muted,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          size: 20,
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 13,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    height: 40,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: kategoriKuliner.length,
                                      separatorBuilder: (_, i) =>
                                          const SizedBox(width: 6),
                                      itemBuilder: (_, i) => ChoiceChip(
                                        label: Text(
                                          kategoriKuliner[i] == 'Semua'
                                              ? _tr('Semua', 'All', 'Sadaya')
                                              : kategoriKuliner[i],
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color:
                                                category == kategoriKuliner[i]
                                                ? _accent
                                                : textColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        side: BorderSide(
                                          color: category == kategoriKuliner[i]
                                              ? _accent
                                              : lineColor,
                                        ),
                                        selected:
                                            category == kategoriKuliner[i],
                                        onSelected: (_) => setState(
                                          () => category = kategoriKuliner[i],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Positioned(
                            left: 18,
                            bottom: 16,
                            child: Text(
                              _tr(
                                'Peta ilustrasi',
                                'Illustrative map',
                                'Peta ilustrasi',
                              ),
                              style: TextStyle(
                                fontSize: 10,
                                color: _muted,
                                backgroundColor: _isDark
                                    ? const Color(0xCC1E1E1E)
                                    : const Color(0xCCFFFFFF),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 14,
                            child: FloatingActionButton.small(
                              heroTag: 'maps-location',
                              tooltip: _tr(
                                'Lokasi contoh saya',
                                'My sample location',
                                'Lokasi conto abdi',
                              ),
                              backgroundColor: cardColor,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              onPressed: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _tr(
                                          'Lokasi contoh: sekitar Gedung Sate, Bandung.',
                                          'Sample location: near Gedung Sate, Bandung.',
                                          'Lokasi conto: sakitaran Gedung Sate, Bandung.',
                                        ),
                                      ),
                                    ),
                                  ),
                              child: Icon(
                                Icons.my_location,
                                color: textColor,
                                size: 21,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 105),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 32,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: lineColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          direction ? directionPanel() : placesPanel(results),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget placesPanel(List<Restaurant> results) {
    final textColor = _isDark ? Colors.white : _ink;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                nearby
                    ? _tr('Kuliner terdekat', 'Nearby Culinary', 'Kuliner Caket')
                    : _tr('Di sekitar kamu', 'Around You', 'Di Sakitar Anjeun'),
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => nearby = !nearby),
              child: Text(
                nearby
                    ? _tr('Ringkas', 'Compact', 'Ringkes')
                    : _tr('Lihat semua', 'See all', 'Tingali sadaya'),
                style: const TextStyle(
                  color: _accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Text(
          _tr(
            '${results.length} pilihan kuliner di sekitarmu',
            '${results.length} culinary options around you',
            '${results.length} pilihan kuliner di sakitar anjeun',
          ),
          style: const TextStyle(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 12),
        if (results.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _tr(
                'Tempat tidak ditemukan. Coba kata kunci atau kategori lain.',
                'No places found. Try another keyword or category.',
                'Tempat teu kapanggih. Cobi kecap konci atanapi kategori sanés.',
              ),
              style: TextStyle(color: textColor),
            ),
          )
        else if (nearby)
          ...results.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: restaurantCard(r),
            ),
          )
        else
          restaurantCard(results.contains(selected) ? selected : results.first),
      ],
    );
  }

  Widget restaurantCard(Restaurant r) {
    final textColor = _isDark ? Colors.white : _ink;
    final subBoxColor = _isDark
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFF7F8F6);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: subBoxColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: _isDark
                      ? Colors.orange.withValues(alpha: 0.15)
                      : _soft,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  r.category == 'Cafe'
                      ? Icons.local_cafe
                      : Icons.restaurant_menu,
                  color: _accent,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${r.category} • ${r.location}',
                      style: const TextStyle(color: _muted, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '★ ${r.rating}  •  ${r.distance}',
                      style: const TextStyle(color: _accent, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(r.address, style: const TextStyle(fontSize: 12, color: _muted)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  r.priceRange,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => preview(r),
                icon: const Icon(Icons.directions_outlined, size: 18),
                label: Text(_tr('Lihat rute', 'View route', 'Tingali rute')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget directionPanel() {
    final speed = vehicle == 'Jalan kaki' ? 4 : (vehicle == 'Mobil' ? 18 : 24);
    final minutes = (distance(selected) / speed * 60).ceil();
    final textColor = _isDark ? Colors.white : _ink;
    final subBoxColor = _isDark
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFF7F8F7);
    final lineColor = _isDark ? Colors.grey.shade800 : _line;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _tr('Rute perjalanan', 'Travel route', 'Rute perjalanan'),
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: subBoxColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 3),
                  const Icon(
                    Icons.radio_button_checked,
                    size: 17,
                    color: _muted,
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: lineColor,
                  ),
                  const Icon(Icons.location_on, size: 19, color: _accent),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _tr(
                        'Dari lokasi kamu',
                        'From your location',
                        'Ti lokasi anjeun',
                      ),
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _tr(
                        'Sekitar Gedung Sate',
                        'Near Gedung Sate',
                        'Sakitaran Gedung Sate',
                      ),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1, color: lineColor),
                    ),
                    Text(
                      selected.name,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selected.address,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              [
                ('Motor', Icons.two_wheeler),
                ('Mobil', Icons.directions_car_outlined),
                ('Jalan kaki', Icons.directions_walk),
              ].map((item) {
                final active = vehicle == item.$1;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: item.$1 == 'Jalan kaki' ? 0 : 8,
                    ),
                    child: Semantics(
                      selected: active,
                      button: true,
                      child: Material(
                        color: active
                            ? (_isDark
                                  ? Colors.orange.withValues(alpha: 0.2)
                                  : _soft)
                            : subBoxColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: active ? _accent : lineColor,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => setState(() {
                            vehicle = item.$1;
                            started = false;
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 4,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.$2,
                                  size: 23,
                                  color: active ? _accent : _muted,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.$1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: active ? _accent : textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
        Text(
          '$minutes ${_tr('menit', 'min', 'menit')} • ${selected.distance}',
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _tr(
            'Estimasi contoh, bukan kondisi perjalanan sebenarnya.',
            'Sample estimate, not actual traffic conditions.',
            'Éstimasi conto, sanés kondisi perjalanan saleresna.',
          ),
          style: const TextStyle(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 16),
        if (started)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isDark ? Colors.orange.withValues(alpha: 0.2) : _soft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _tr(
                'Simulasi navigasi aktif\nIkuti garis oranye menuju marker tujuan.',
                'Navigation simulation active\nFollow the orange line to the destination marker.',
                'Simulasi navigasi aktip\nTuturkeun garis oranye nuju tujuan.',
              ),
              style: TextStyle(color: textColor),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: _accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => setState(() => started = !started),
            icon: Icon(
              started ? Icons.stop_circle_outlined : Icons.navigation_outlined,
            ),
            label: Text(
              started
                  ? _tr('Akhiri simulasi', 'End simulation', 'ungkas simulasi')
                  : _tr('Mulai navigasi', 'Start navigation', 'Mimitian navigasi'),
            ),
          ),
        ),
      ],
    );
  }
}

/// Menggambar jalan, taman, sungai, lokasi contoh, dan garis rute secara lokal.
class _MapPainter extends CustomPainter {
  final Offset destination;
  final bool showRoute;
  final bool isDark;
  const _MapPainter({
    required this.destination,
    required this.showRoute,
    this.isDark = false,
  });
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = isDark ? const Color(0xFF1A1E1C) : const Color(0xFFECEEEA),
    );
    Offset point(double x, double y) => Offset(x * size.width, y * size.height);
    Offset location(Offset p) =>
        Offset(p.dx * size.width, 140 + (size.height - 190) * p.dy);
    for (final r in [
      const Rect.fromLTWH(.07, .08, .18, .23),
      const Rect.fromLTWH(.57, .62, .18, .24),
      const Rect.fromLTWH(.75, .10, .16, .18),
    ]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            r.left * size.width,
            r.top * size.height,
            r.width * size.width,
            r.height * size.height,
          ),
          const Radius.circular(18),
        ),
        Paint()
          ..color = isDark ? const Color(0xFF233026) : const Color(0xFFDCE7D4),
      );
    }
    final river = Path()
      ..moveTo(size.width * .88, 0)
      ..cubicTo(
        size.width * .40,
        size.height * .35,
        size.width,
        size.height * .60,
        size.width * .61,
        size.height,
      );
    canvas.drawPath(
      river,
      Paint()
        ..color = isDark ? const Color(0xFF1F363D) : const Color(0xFFCCE0E4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13,
    );
    final road = Paint()
      ..color = isDark ? const Color(0xFF2B312E) : Colors.white
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    for (var i = -2; i < 9; i++) {
      canvas.drawLine(point(i * .16, 0), point(i * .16 + .26, 1), road);
      canvas.drawLine(point(0, i * .16), point(1, i * .16 - .26), road);
    }
    void label(String text, Offset position) {
      final p = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: isDark ? Colors.grey.shade400 : const Color(0xFF788075),
            fontSize: 11,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      p.paint(canvas, position);
    }

    label('DAGO', point(.41, .48));
    label('Cihapit', point(.10, .64));
    label('Jl. Ir. H. Juanda', point(.36, .39));
    label('Gedung Sate', point(.31, .90));
    final origin = location(const Offset(.45, .57));
    if (showRoute) {
      final route = Path()
        ..moveTo(origin.dx, origin.dy)
        ..lineTo(
          location(const Offset(.52, .55)).dx,
          location(const Offset(.52, .55)).dy,
        )
        ..lineTo(
          location(const Offset(.47, .35)).dx,
          location(const Offset(.47, .35)).dy,
        )
        ..lineTo(location(destination).dx, location(destination).dy);
      canvas.drawPath(
        route,
        Paint()
          ..color = isDark ? const Color(0xFF2B312E) : Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9,
      );
      canvas.drawPath(
        route,
        Paint()
          ..color = _accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeJoin = StrokeJoin.round,
      );
    }
    canvas.drawCircle(origin, 17, Paint()..color = const Color(0x303197EF));
    canvas.drawCircle(origin, 8, Paint()..color = Colors.white);
    canvas.drawCircle(origin, 5, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) =>
      oldDelegate.destination != destination ||
      oldDelegate.showRoute != showRoute ||
      oldDelegate.isDark != isDark;
}
