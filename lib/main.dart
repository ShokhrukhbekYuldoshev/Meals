import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';

import 'app.dart';
import 'core/di/injector.dart';

Future<void> main() async {
  // Ensure that the Flutter binding has been initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  init();

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
