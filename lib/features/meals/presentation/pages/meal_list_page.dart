import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/categories/data/models/category_model.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:meals/features/meals/presentation/widgets/meal_item.dart';

class MealListPage extends StatefulWidget {
  final CategoryModel category;

  const MealListPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final List<MealEntity> meals = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsBloc>(context).add(
      FetchMealsByQuery("c=${widget.category.name}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name ?? ''),
      ),
      body: BlocListener<MealsBloc, MealsState>(
        listener: (context, state) {
          if (state is MealsLoaded) {
            meals.clear();
            meals.addAll(state.meals);
          }
        },
        child: BlocBuilder<MealsBloc, MealsState>(
          builder: (context, state) {
            if (state is MealsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MealsError) {
              return Center(
                child: Text(state.message),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];

                return MealItem(meal: meal);
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 0.6,
                crossAxisSpacing: 50,
                mainAxisSpacing: 50,
              ),
            );
          },
        ),
      ),
    );
  }
}
