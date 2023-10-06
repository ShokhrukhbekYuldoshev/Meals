import 'package:meals/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meals/features/meals/data/datasources/meal_datasource.dart';
import 'package:meals/features/meals/data/models/meal_model.dart';
import 'package:meals/features/meals/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealDatasource mealDatasource;

  MealRepositoryImpl(this.mealDatasource);

  @override
  Future<Either<Failure, List<MealModel>>> getMealsByQuery(String query) async {
    try {
      final response = await mealDatasource.fetchMealsByQuery(query);
      final meals = (response.data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();

      return Right(meals);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MealModel>> getMealsById(String id) async {
    try {
      final response = await mealDatasource.fetchMealById(id);
      final meal = MealModel.fromJson(response.data['meals'][0]);

      return Right(meal);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
