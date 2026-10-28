import 'package:flutter/material.dart';

import '../features/favorites/favorites_page.dart';
import '../features/home/home_page.dart';
import '../features/maps/maps_page.dart';
import '../features/profile/profile_page.dart';
import '../features/search/search_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Daftar 5 Halaman Utama sesuai BottomNavigationBar (Modul 6.2.3.2)
  final List<Widget> _pages = const [
    HomePage(),      // Bagian Orang 1
    SearchPage(),    // Bagian Orang 1
    MapsPage(),      // Bagian Orang 3
    FavoritesPage(), // Bagian Orang 4
    ProfilePage(),   // Bagian Orang 5
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
