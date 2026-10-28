import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/profile/edit_profile_page.dart';
import 'navigation/main_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: UserProfileData.settingsNotifier,
      builder: (context, _, _) {
        final isDark = UserProfileData.isDarkMode;
        return MaterialApp(
          title: 'Bandung Foodies',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: const MainScaffold(),
        );
      },
    );
  }
}
