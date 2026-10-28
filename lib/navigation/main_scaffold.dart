import 'dart:ui';

import 'package:flutter/material.dart';

import '../features/favorites/favorites_page.dart';
import '../features/home/home_page.dart';
import '../features/maps/maps_page.dart';
import '../features/profile/edit_profile_page.dart';
import '../features/profile/profile_page.dart';
import '../features/search/search_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: UserProfileData.settingsNotifier,
      builder: (context, _, _) {
        final isDark = UserProfileData.isDarkMode;
        final lang = UserProfileData.currentUser.language;

        // Daftar 5 Halaman Utama sesuai BottomNavigationBar (Modul 6.2.3.2)
        final List<Widget> pages = [
          HomePage(key: ValueKey('home_${lang}_$isDark')), // Bagian Orang 1
          SearchPage(key: ValueKey('search_${lang}_$isDark')), // Bagian Orang 1
          MapsPage(key: ValueKey('maps_${lang}_$isDark')), // Bagian Orang 3
          FavoritesPage(key: ValueKey('fav_${lang}_$isDark')), // Bagian Orang 4
          ProfilePage(key: ValueKey('prof_${lang}_$isDark')), // Bagian Orang 5
        ];

        final navItems = [
          _NavItemData(
            activeIcon: Icons.home_rounded,
            inactiveIcon: Icons.home_outlined,
            label: UserProfileData.tr('Beranda', 'Home', 'Tepas'),
          ),
          _NavItemData(
            activeIcon: Icons.manage_search_rounded,
            inactiveIcon: Icons.search_rounded,
            label: UserProfileData.tr('Cari', 'Search', 'Milari'),
          ),
          _NavItemData(
            activeIcon: Icons.explore_rounded,
            inactiveIcon: Icons.explore_outlined,
            label: UserProfileData.tr('Peta', 'Maps', 'Peta'),
            isCenterFeature: true,
          ),
          _NavItemData(
            activeIcon: Icons.favorite_rounded,
            inactiveIcon: Icons.favorite_border_rounded,
            label: UserProfileData.tr('Favorit', 'Favorite', 'Karesep'),
          ),
          _NavItemData(
            activeIcon: Icons.person_rounded,
            inactiveIcon: Icons.person_outline_rounded,
            label: UserProfileData.tr('Profil', 'Profile', 'Profil'),
          ),
        ];

        return Scaffold(
          extendBody: true,
          backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
          body: Stack(
            children: [
              // 1. Konten Halaman Utama (Tanpa animasi perpindahan page)
              Positioned.fill(
                child: pages[_selectedIndex],
              ),

              // 2. Floating Navbar Semi-Transparan dengan Animasi Sliding Pill
              Positioned(
                left: 16,
                right: 16,
                bottom: 12,
                child: SafeArea(
                  top: false,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.45)
                              : Colors.black.withValues(alpha: 0.09),
                          blurRadius: 22,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          height: 68,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E1E1E).withValues(alpha: 0.75)
                                : Colors.white.withValues(alpha: 0.78),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.12)
                                  : Colors.white.withValues(alpha: 0.65),
                              width: 1.2,
                            ),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final itemWidth = constraints.maxWidth / 5;
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Kapsul Oranye yang Meluncur Tepat di Tengah Setiap Item
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOutCubic,
                                    left: (_selectedIndex * itemWidth) + 3,
                                    top: 0,
                                    bottom: 0,
                                    width: itemWidth - 6,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFF9800),
                                            Color(0xFFF57C00),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(22),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.orange.withValues(
                                              alpha: 0.35,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Daftar Item Menu Navbar di Atas Sliding Pill
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      navItems.length,
                                      (index) {
                                        final item = navItems[index];
                                        final isSelected =
                                            _selectedIndex == index;
                                        return Expanded(
                                          child: _buildAnimatedNavItem(
                                            item: item,
                                            isSelected: isSelected,
                                            isDark: isDark,
                                            onTap: () {
                                              if (_selectedIndex == index) {
                                                return;
                                              }
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedNavItem({
    required _NavItemData item,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final inactiveColor = isDark ? Colors.grey.shade300 : Colors.grey.shade700;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: (!isSelected && item.isCenterFeature)
              ? (isDark
                    ? Colors.orange.withValues(alpha: 0.14)
                    : Colors.orange.withValues(alpha: 0.12))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animasi Ikon
              AnimatedScale(
                scale: isSelected ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                child: Icon(
                  isSelected ? item.activeIcon : item.inactiveIcon,
                  size: 20,
                  color: isSelected
                      ? Colors.white
                      : (item.isCenterFeature ? Colors.orange : inactiveColor),
                ),
              ),
              const SizedBox(height: 2),
              // Animasi Teks Label
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : (item.isCenterFeature
                            ? Colors.orange.shade700
                            : inactiveColor),
                ),
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              // Garis Indikator Kecil di Bawah Label Aktif
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                width: isSelected ? 12 : 0,
                height: 2.5,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.amber.shade200
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final bool isCenterFeature;

  const _NavItemData({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    this.isCenterFeature = false,
  });
}
