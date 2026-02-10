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
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<MealsBloc>().add(LookupRandomMeal());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1024;

        return Scaffold(
          appBar: AppBar(title: const Text('Meals'), centerTitle: !isDesktop),
          body: Row(
            children: [
              if (isDesktop) _buildNavigationRail(),
              Expanded(child: _buildBody(constraints.maxWidth)),
            ],
          ),
          bottomNavigationBar: isDesktop ? null : _buildBottomNavigation(),
        );
      },
    );
  }

  // ================= NAVIGATION =================

  Widget _buildBottomNavigation() {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() => selectedIndex = index);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.category), label: 'Categories'),
      ],
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() => selectedIndex = index);
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
        NavigationRailDestination(
          icon: Icon(Icons.category),
          label: Text('Categories'),
        ),
      ],
    );
  }

  // ================= BODY =================

  Widget _buildBody(double width) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: IndexedStack(
          index: selectedIndex,
          children: [_buildHomeTab(width), const CategoriesPage()],
        ),
      ),
    );
  }

  // ================= HOME TAB =================

  Widget _buildHomeTab(double width) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildMealBanner()),
        SliverToBoxAdapter(child: _buildSearchBar()),
        SliverToBoxAdapter(child: _buildMealsByFirstLetter(width)),
        const SliverPadding(padding: EdgeInsets.only(bottom: 48)),
      ],
    );
  }

  // ================= RANDOM MEAL =================

  Widget _buildMealBanner() {
    return BlocBuilder<MealsBloc, MealsState>(
      buildWhen: (_, current) => current is RandomMealLoaded,
      builder: (context, state) {
        if (state is MealsLoading) {
          return const Padding(
            padding: EdgeInsets.all(48),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MealsError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state.message,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        if (state is RandomMealLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: MealBannerWidget(meal: state.meal),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ================= SEARCH =================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Search meals...',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.trim().isEmpty) return;

            Navigator.of(context).pushNamed(
              AppRouter.mealListRoute,
              arguments: MealListPageArguments(
                event: SearchMealsByName(value),
                title: 'Search results for "$value"',
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= A–Z GRID =================

  Widget _buildMealsByFirstLetter(double width) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    final isDesktop = width >= 900;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Browse by letter',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 8),
              Text(
                'A–Z',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: isDesktop ? 8 : 10,
            runSpacing: isDesktop ? 8 : 10,
            children: letters.split('').map((letter) {
              return _LetterChip(
                letter: letter,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRouter.mealListRoute,
                    arguments: MealListPageArguments(
                      event: ListMealsByFirstLetter(letter),
                      title: 'Meals starting with $letter',
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _LetterChip extends StatelessWidget {
  final String letter;
  final VoidCallback onTap;

  const _LetterChip({required this.letter, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            letter,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
