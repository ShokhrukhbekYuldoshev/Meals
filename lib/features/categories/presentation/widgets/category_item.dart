import 'package:flutter/material.dart';
import 'package:meals/core/router/app_router.dart';
import 'package:meals/features/categories/domain/entities/category_entity.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withAlpha(5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouter.mealsRoute,
            arguments: category,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                category.thumbnail ?? '',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                category.name ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
