import 'package:flutter/material.dart';

import 'core/di/injector.dart';
import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: sl<AppTheme>().lightTheme,
      darkTheme: sl<AppTheme>().darkTheme,
      // themeMode: ThemeMode.light,
      onGenerateRoute: (settings) => sl<AppRouter>().generateRoute(settings),
    );
  }
}
