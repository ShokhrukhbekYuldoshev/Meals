import 'package:flutter/material.dart';
import 'package:meals/core/router/app_router.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';

class MealBannerWidget extends StatelessWidget {
  final MealEntity meal;

  const MealBannerWidget({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouter.mealDetailsRoute,
          arguments: meal.id,
        );
      },
      child: SizedBox(
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              meal.thumbnail ?? '',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                meal.name,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
