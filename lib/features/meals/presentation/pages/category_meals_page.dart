import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/categories/data/models/category_model.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:meals/features/meals/presentation/widgets/meal_item.dart';

class MealsPage extends StatefulWidget {
  final CategoryModel category;

  const MealsPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
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
      body: BlocBuilder<MealsBloc, MealsState>(
        builder: (context, state) {
          if (state is MealsLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: state.meals.length,
              itemBuilder: (context, index) {
                final meal = state.meals[index];

                return MealItem(meal: meal);
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 0.6,
                crossAxisSpacing: 50,
                mainAxisSpacing: 50,
              ),
            );
          } else if (state is MealsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MealsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
