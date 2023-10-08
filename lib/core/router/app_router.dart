import 'package:flutter/material.dart';
import 'package:meals/features/categories/presentation/pages/categories_page.dart';
import 'package:meals/features/meals/presentation/pages/home_page.dart';
import 'package:meals/features/meals/presentation/pages/meal_details_page.dart';
import 'package:meals/features/meals/presentation/pages/meal_list_page.dart';

class AppRouter {
  static const String initialRoute = '/';
  static const String categoryListRoute = '/categories';
  static const String mealListRoute = '/meals';
  static const String mealDetailsRoute = '/meal-details';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case categoryListRoute:
        return MaterialPageRoute(builder: (_) => const CategoriesPage());
      case mealListRoute:
        return MaterialPageRoute(
          builder: (_) => MealListPage(
            arguments: settings.arguments as MealListPageArguments,
          ),
        );
      case mealDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => MealDetailsPage(
            id: settings.arguments as String,
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
