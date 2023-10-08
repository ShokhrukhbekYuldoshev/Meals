import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/core/router/app_router.dart';
import 'package:meals/features/categories/presentation/pages/categories_page.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:meals/features/meals/presentation/pages/meal_list_page.dart';
import 'package:meals/features/meals/presentation/widgets/meal_banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<MealsBloc>(context).add(LookupRandomMeal());
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.star),
          //   label: 'Favorites',
          // ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMealBanner(),
                _buildSearchBar(),
                _buildMealsByFirstLetter(),
              ],
            ),
          ),
          const CategoriesPage(),
          // FavoritesPage(),
        ],
      ),
    );
  }

  // Show a random meal banner
  Widget _buildMealBanner() {
    return BlocBuilder<MealsBloc, MealsState>(
      buildWhen: (previous, current) => current is RandomMealLoaded,
      builder: (context, state) {
        if (state is MealsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MealsError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is RandomMealLoaded) {
          return MealBannerWidget(meal: state.meal);
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search meals',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onSubmitted: (value) {
          if (value.isEmpty) return;
          Navigator.of(context).pushNamed(
            AppRouter.mealListRoute,
            arguments: MealListPageArguments(
              event: SearchMealsByName(value),
              title: 'Search results for $value',
            ),
          );
        },
      ),
    );
  }

  // List all meals by first letter: return a-z list clickable
  Widget _buildMealsByFirstLetter() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return Flexible(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Meals by first letter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          ListView.builder(
            itemCount: letters.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final letter = letters[index];
              return ListTile(
                title: Text(letter),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRouter.mealListRoute,
                    arguments: MealListPageArguments(
                      event: ListMealsByFirstLetter(letter),
                      title: 'Meals by $letter',
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
