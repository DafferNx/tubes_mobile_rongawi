import 'package:flutter/material.dart';

import 'features/home/home_page.dart'; // Sesuaikan path jika berbeda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(), // Ganti menjadi SearchPage() untuk melihat layar pencarian
    );
  }
}
