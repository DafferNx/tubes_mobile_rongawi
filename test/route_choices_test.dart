import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes_mobile_rongawi/core/widgets/route_choices.dart';
import 'package:tubes_mobile_rongawi/data/dummy_restaurants.dart';
import 'package:tubes_mobile_rongawi/features/maps/maps.dart';

void main() {
  testWidgets('Dua pilihan terpisah dan Google Maps hanya pratinjau', (
    tester,
  ) async {
    var routeOpened = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RouteChoices(
            restaurant: dummyRestaurants.first,
            onRoute: () => routeOpened = true,
          ),
        ),
      ),
    );
    expect(find.text('atau'), findsOneWidget);
    await tester.tap(find.text('Gunakan Google Maps'));
    await tester.pumpAndSettle();
    expect(find.text('Berhasil'), findsOneWidget);
    expect(routeOpened, isFalse);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lihat rute'));
    expect(routeOpened, isTrue);
  });
  testWidgets('Rute dari detail membuka tempat terpilih di dalam aplikasi', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: MapsPage(initialRestaurant: dummyRestaurants[2])),
    );
    await tester.pumpAndSettle();
    expect(find.text('Rute perjalanan'), findsOneWidget);
    expect(find.text('Gunakan Google Maps'), findsOneWidget);
    expect(find.text('Mulai navigasi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
