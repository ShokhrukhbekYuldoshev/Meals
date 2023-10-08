import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:meals/features/categories/presentation/widgets/category_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CategoriesLoaded) {
          return ListView.builder(
            itemCount: state.categories.length,
            padding: const EdgeInsets.all(25),
            itemBuilder: (context, index) {
              final category = state.categories[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CategoryItem(category: category),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        } else if (state is CategoriesError) {
          return Text(state.message);
        }
        return Container(); // Default empty state.
      },
    );
  }
}
