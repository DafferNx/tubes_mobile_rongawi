import 'package:flutter/material.dart';

import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/favorites/favorites_page.dart';
import '../features/home/home_page.dart';
import '../features/maps/maps_page.dart';
import '../features/profile/edit_profile_page.dart';
import '../features/profile/profile_page.dart';
import '../features/restaurant/menu_detail_page.dart';
import '../features/restaurant/restaurant_detail_page.dart';
import '../features/reviews/reviews_page.dart';
import '../features/search/filter_page.dart';
import '../features/search/search_page.dart';
import 'main_scaffold.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const MainScaffold(),
    '/home': (context) => const HomePage(),
    '/search': (context) => const SearchPage(),
    '/filter': (context) => const FilterPage(),
    '/restaurant-detail': (context) => const RestaurantDetailPage(),
    '/menu-detail': (context) => const MenuDetailPage(),
    '/maps': (context) => const MapsPage(),
    '/reviews': (context) => const ReviewsPage(),
    '/favorites': (context) => const FavoritesPage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/profile': (context) => const ProfilePage(),
    '/edit-profile': (context) => const EditProfilePage(),
  };
}
