import 'package:flutter/material.dart';
import 'package:meals/features/categories/data/models/category_model.dart';
import 'package:meals/features/categories/presentation/pages/categories_page.dart';
import 'package:meals/features/meals/presentation/pages/category_meals_page.dart';

class AppRouter {
  static const String initialRoute = '/';
  static const String categoriesRoute = '/categories';
  static const String mealsRoute = '/meals';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const CategoriesPage());
      case mealsRoute:
        return MaterialPageRoute(
          builder: (_) => MealsPage(
            category: settings.arguments as CategoryModel,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
