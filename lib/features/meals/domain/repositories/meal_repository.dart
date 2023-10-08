import 'package:meals/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';

abstract class MealRepository {
  Future<Either<Failure, List<MealEntity>>> getMealsByQuery(String query);

  Future<Either<Failure, MealEntity>> getMealsById(String id);

  Future<Either<Failure, List<MealEntity>>> listMealsByFirstLetter(
    String letter,
  );

  Future<Either<Failure, MealEntity>> lookupRandomMeal();

  Future<Either<Failure, List<MealEntity>>> searchMealsByName(String name);
}
