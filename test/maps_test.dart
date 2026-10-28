import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes_mobile_rongawi/features/maps/maps.dart';

void main() {
  testWidgets('Maps: filter, nearby, route and navigation simulation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: MapsPage()));
    expect(find.text('Peta ilustrasi'), findsOneWidget);
    await tester.tap(find.text('Lihat semua'));
    await tester.pumpAndSettle();
    expect(find.text('Kuliner terdekat'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'tidak-ada');
    await tester.pumpAndSettle();
    expect(find.textContaining('Tempat tidak ditemukan'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Seblak');
    await tester.pumpAndSettle();
    expect(find.text('Seblak Mercon Bandung'), findsOneWidget);
    await tester.ensureVisible(find.text('Lihat rute'));
    await tester.tap(find.text('Lihat rute'));
    await tester.pumpAndSettle();
    expect(find.text('Petunjuk arah'), findsOneWidget);
    await tester.ensureVisible(find.text('Jalan kaki'));
    await tester.tap(find.text('Jalan kaki'));
    await tester.pumpAndSettle();
    expect(find.text('18 menit • 1.2 km'), findsOneWidget);
    await tester.ensureVisible(find.text('Mulai navigasi'));
    await tester.tap(find.text('Mulai navigasi'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Simulasi navigasi aktif'), findsOneWidget);
    await tester.ensureVisible(find.text('Akhiri simulasi'));
    await tester.tap(find.text('Akhiri simulasi'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byTooltip('Kembali ke peta'));
    await tester.tap(find.byTooltip('Kembali ke peta'));
    await tester.pumpAndSettle();
    expect(find.text('Jelajah kuliner'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Maps fits a small screen with enlarged text', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.3)),
          child: child!,
        ),
        home: const MapsPage(),
      ),
    );
    await tester.ensureVisible(find.text('Lihat rute'));
    await tester.tap(find.text('Lihat rute'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Mulai navigasi'));
    expect(tester.takeException(), isNull);
  });
}
