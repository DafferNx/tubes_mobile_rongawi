import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';

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
    // Tema lokal agar halaman anggota lain tidak ikut berubah.
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange).copyWith(
          primary: _accent,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: _ink,
          onSurfaceVariant: _muted,
          primaryContainer: _soft,
          onPrimaryContainer: _accent,
          secondaryContainer: _soft,
          onSecondaryContainer: _accent,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          selectedColor: _soft,
          side: BorderSide.none,
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          labelStyle: const TextStyle(
            color: _ink,
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
        backgroundColor: Colors.white,
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
                                            : Colors.white,
                                        foregroundColor: e.value == selected
                                            ? Colors.white
                                            : _accent,
                                        side: BorderSide(
                                          color: Colors.white,
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
                                    color: Colors.white,
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
                                            ? 'Kembali ke peta'
                                            : 'Lokasi Bandung',
                                        onPressed: () {
                                          if (direction) {
                                            setState(() {
                                              direction = false;
                                              started = false;
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Lokasi contoh: Bandung, Jawa Barat.',
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
                                                  ? 'Petunjuk arah'
                                                  : 'Jelajah kuliner',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            const Text(
                                              'Bandung, Jawa Barat',
                                              style: TextStyle(
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: TextField(
                                      onChanged: (v) =>
                                          setState(() => query = v),
                                      style: const TextStyle(fontSize: 13),
                                      decoration: InputDecoration(
                                        hintText: 'Cari tempat atau kawasan...',
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
                                          kategoriKuliner[i],
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color:
                                                category == kategoriKuliner[i]
                                                ? _accent
                                                : _ink,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        side: BorderSide(
                                          color: category == kategoriKuliner[i]
                                              ? _accent
                                              : _line,
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
                          const Positioned(
                            left: 18,
                            bottom: 16,
                            child: Text(
                              'Peta ilustrasi',
                              style: TextStyle(
                                fontSize: 10,
                                color: _muted,
                                backgroundColor: Color(0xCCFFFFFF),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 14,
                            child: FloatingActionButton.small(
                              heroTag: 'maps-location',
                              tooltip: 'Lokasi contoh saya',
                              backgroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              onPressed: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Lokasi contoh: sekitar Gedung Sate, Bandung.',
                                      ),
                                    ),
                                  ),
                              child: const Icon(
                                Icons.my_location,
                                color: _ink,
                                size: 21,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
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
                              color: const Color(0xFFE2E5E3),
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

  Widget placesPanel(List<Restaurant> results) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              nearby ? 'Kuliner terdekat' : 'Di sekitar kamu',
              style: const TextStyle(
                color: _ink,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => nearby = !nearby),
            child: Text(
              nearby ? 'Ringkas' : 'Lihat semua',
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
        '${results.length} pilihan kuliner di sekitarmu',
        style: const TextStyle(color: _muted, fontSize: 12),
      ),
      const SizedBox(height: 12),
      if (results.isEmpty)
        const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Tempat tidak ditemukan. Coba kata kunci atau kategori lain.',
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

  Widget restaurantCard(Restaurant r) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F8F6),
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
                color: _soft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                r.category == 'Cafe' ? Icons.local_cafe : Icons.restaurant_menu,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${r.category} • ${r.location}',
                    style: const TextStyle(color: _muted, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '★ ${r.rating}  •  ${r.distance}',
                    style: TextStyle(color: _accent, fontSize: 12),
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
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
              label: const Text('Lihat rute'),
            ),
          ],
        ),
      ],
    ),
  );

  Widget directionPanel() {
    final speed = vehicle == 'Jalan kaki' ? 4 : (vehicle == 'Mobil' ? 18 : 24);
    final minutes = (distance(selected) / speed * 60).ceil();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rute perjalanan',
          style: TextStyle(
            color: _ink,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8F7),
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
                    color: _line,
                  ),
                  const Icon(Icons.location_on, size: 19, color: _accent),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dari lokasi kamu',
                      style: TextStyle(color: _muted, fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Sekitar Gedung Sate',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1, color: _line),
                    ),
                    Text(
                      selected.name,
                      style: const TextStyle(
                        color: _ink,
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
                        color: active ? _soft : const Color(0xFFF7F8F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: active ? _accent : _line),
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
                                    color: active ? _accent : _ink,
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
          '$minutes menit • ${selected.distance}',
          style: const TextStyle(
            color: _ink,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Estimasi contoh, bukan kondisi perjalanan sebenarnya.',
          style: TextStyle(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 16),
        if (started)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _soft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Simulasi navigasi aktif\nIkuti garis oranye menuju marker tujuan.',
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
            label: Text(started ? 'Akhiri simulasi' : 'Mulai navigasi'),
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
  const _MapPainter({required this.destination, required this.showRoute});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFECEEEA),
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
        Paint()..color = const Color(0xFFDCE7D4),
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
        ..color = const Color(0xFFCCE0E4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13,
    );
    final road = Paint()
      ..color = Colors.white
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
          style: const TextStyle(color: Color(0xFF788075), fontSize: 11),
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
          ..color = Colors.white
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
      oldDelegate.showRoute != showRoute;
}
