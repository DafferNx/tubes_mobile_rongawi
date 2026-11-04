import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes_mobile_rongawi/features/profile/profile_page.dart';
import 'package:tubes_mobile_rongawi/features/community/demo_pages.dart';

void main() {
  testWidgets('Profil dapat digulir tanpa assertion ListTile', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));
    expect(tester.takeException(), isNull);
    for (var i = 0; i < 12; i++) {
      await tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -400),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });
  testWidgets('Tambah teman hanya menampilkan pratinjau', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FriendsPage()));
    await tester.tap(find.byTooltip('Tambah teman'));
    await tester.pumpAndSettle();
    expect(find.text('Berhasil'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Tambah teman'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
