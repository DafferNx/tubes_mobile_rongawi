import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes_mobile_rongawi/navigation/main_scaffold.dart';
import 'package:tubes_mobile_rongawi/features/maps/location_detail_page.dart';
import 'package:tubes_mobile_rongawi/data/dummy_restaurants.dart';

void main() {
  testWidgets('Navbar tetap tampil di detail, rute, dan saat berpindah tab', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: MainScaffold()));
    await tester.pumpAndSettle();
    final navigator = tester.state<NavigatorState>(find.byType(Navigator).last);
    navigator.push(
      MaterialPageRoute<void>(
        builder: (_) => LocationDetailPage(restaurant: dummyRestaurants.first),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Profil'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Lihat rute'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -220));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lihat rute'));
    await tester.pumpAndSettle();
    expect(find.text('Rute perjalanan'), findsOneWidget);
    expect(find.byIcon(Icons.explore_rounded), findsOneWidget);
    expect(find.byIcon(Icons.home_rounded), findsNothing);
    await tester.scrollUntilVisible(
      find.text('Gunakan Google Maps'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -240));
    await tester.pumpAndSettle();
    expect(
      tester.getBottomRight(find.text('Gunakan Google Maps')).dy,
      lessThan(tester.getTopLeft(find.text('Profil')).dy - 30),
    );
    expect(find.text('Profil'), findsOneWidget);
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Rute perjalanan'), findsNothing);
    await tester.tap(find.text('Peta').last);
    await tester.pumpAndSettle();
    expect(find.text('Rute perjalanan'), findsOneWidget);
    await tester.drag(find.byType(Scrollable).last, const Offset(0, 1500));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Kembali ke peta'));
    await tester.pumpAndSettle();
    expect(find.text('Rute perjalanan'), findsNothing);
    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    expect(find.text('Detail tempat makan'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
