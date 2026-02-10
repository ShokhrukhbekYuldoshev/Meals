import 'package:flutter/material.dart';
import 'package:meals/core/router/app_router.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';

class MealBannerWidget extends StatelessWidget {
  final MealEntity meal;
  const MealBannerWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 300, // Fixed height for a consistent "Hero" feel
      width: double.infinity,
      child: Stack(
        children: [
          // 1. The Background Image
          Positioned.fill(
            child: Image.network(
              meal.thumbnail ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.broken_image, size: 50),
              ),
            ),
          ),

          // 2. The Gradient Overlay (Ensures text readability in any theme)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(
                      alpha: 0.8,
                    ), // Darkens the bottom for text
                  ],
                ),
              ),
            ),
          ),

          // 3. The Text Content
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "FEATURED RECIPE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  meal.name,
                  style: const TextStyle(
                    color: Colors.white, // Always white on dark gradient
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (meal.category != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    meal.category!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // 4. InkWell for Interactivity
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate to details
                  Navigator.of(context).pushNamed(
                    AppRouter.mealDetailsRoute, //
                    arguments: meal.id,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
