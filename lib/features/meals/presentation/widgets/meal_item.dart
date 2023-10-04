import 'package:flutter/material.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';

class MealItem extends StatelessWidget {
  final MealEntity meal;
  const MealItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withAlpha(5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   AppRouter.mealsRoute,
          //   arguments: category,
          // );
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
