import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MealDetailsPage extends StatefulWidget {
  final String id;

  const MealDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MealsBloc>(context).add(GetMealById(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state is MealLoaded ? state.meal.name : ''),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  _buildBody(MealsState state) {
    if (state is MealLoaded) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                state.meal.thumbnail ?? '',
                height: 300,
                width: double.infinity,
              ),
              const SizedBox(height: 10),

              // Tags
              state.meal.tags?.isEmpty ?? true
                  ? const SizedBox.shrink()
                  : Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: state.meal.tags!
                          .split(',')
                          .map(
                            (e) => Chip(
                              label: Text(e),
                            ),
                          )
                          .toList(),
                    ),
              const SizedBox(height: 10),

              // Category
              Text(
                "Category: ${state.meal.category}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // Area
              Text(
                "Area: ${state.meal.area}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // Youtube link
              state.meal.youtube == null
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            launchUrlString(state.meal.youtube ?? '');
                          },
                          child: Text(
                            'Watch on YouTube',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),

              // Ingredients
              DataTable(
                // every second row is grey
                headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
                columnSpacing: 0,
                dataRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.08);
                    }
                    return Colors.grey.withOpacity(0.3);
                  },
                ),
                columns: const [
                  DataColumn(label: Text('Ingredient')),
                  DataColumn(label: Text('Measure')),
                ],
                rows: state.meal.ingredients.asMap().entries.map((entry) {
                  final ingredient = entry.value;
                  late final String measure;
                  try {
                    measure = state.meal.measures[entry.key];
                  } catch (e) {
                    measure = '';
                  }

                  return DataRow(
                    cells: [
                      DataCell(Text(ingredient)),
                      DataCell(Text(measure)),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              // Instructions, each sentence is a step is more than 6 characters
              Stepper(
                physics: const NeverScrollableScrollPhysics(),
                steps: state.meal.instructions!
                    .split('.')
                    .where((element) => element.length > 5)
                    .map(
                      (e) => Step(
                        title: Text(e),
                        isActive: true,
                        content: const SizedBox.shrink(),
                      ),
                    )
                    .toList(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return const Row();
                },
              ),
            ],
          ),
        ),
      );
    } else if (state is MealsError) {
      return Center(
        child: Text(state.message),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
