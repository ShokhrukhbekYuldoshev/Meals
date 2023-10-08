import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'package:meals/app.dart';
import 'package:meals/core/di/injector.dart';
import 'package:meals/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';

Future<void> main() async {
  // Ensure that the Flutter binding has been initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  init();

  // Check if the platform is supported
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize WindowManager
    await windowManager.ensureInitialized();

    // Configure WindowManager
    WindowOptions windowOptions = const WindowOptions(
      size: Size(600, 800),
      title: 'Meals',
      minimumSize: Size(300, 400),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // Run app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CategoriesBloc>()..add(FetchCategories()),
        ),
        BlocProvider(
          create: (context) => sl<MealsBloc>(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
