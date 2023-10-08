import 'package:flutter/material.dart';
import 'package:meals/core/router/app_router.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';

class MealItemWidget extends StatelessWidget {
  final MealEntity meal;
  const MealItemWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouter.mealDetailsRoute,
            arguments: meal.id,
          );
        },
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  meal.thumbnail ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              meal.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
