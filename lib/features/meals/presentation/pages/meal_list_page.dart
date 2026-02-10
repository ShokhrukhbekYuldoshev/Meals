import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:meals/features/meals/presentation/widgets/meal_item_widget.dart';

class MealListPageArguments {
  final MealsEvent event;
  final String title;

  MealListPageArguments({required this.event, required this.title});
}

class MealListPage extends StatefulWidget {
  final MealListPageArguments arguments;
  const MealListPage({super.key, required this.arguments});

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final List<MealEntity> meals = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsBloc>(context).add(widget.arguments.event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.arguments.title)),
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealsError) {
              if (state.message == 'EmptyResultFailure()') {
                return const Center(child: Text('No meals found'));
              }
              return const Center(child: Text('Something went wrong'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];

                return MealItemWidget(meal: meal);
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
