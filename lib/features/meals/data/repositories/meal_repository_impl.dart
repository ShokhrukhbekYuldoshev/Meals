import 'package:flutter/foundation.dart';
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
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MealModel>> getMealsById(String id) async {
    try {
      final response = await mealDatasource.fetchMealById(id);
      final meal = MealModel.fromJson(response.data['meals'][0]);

      return Right(meal);
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> listMealsByFirstLetter(
    String letter,
  ) async {
    try {
      final response = await mealDatasource.fetchMealsByFirstLetter(letter);

      if (response.data['meals'] == null) {
        return Left(EmptyResultFailure());
      }

      final meals = (response.data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();

      return Right(meals);
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MealModel>> lookupRandomMeal() async {
    try {
      final response = await mealDatasource.fetchRandomMeal();

      final meal = MealModel.fromJson(response.data['meals'][0]);

      return Right(meal);
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> searchMealsByName(
    String name,
  ) async {
    try {
      final response = await mealDatasource.fetchMealsByName(name);

      if (response.data['meals'] == null) {
        return Left(EmptyResultFailure());
      }

      final meals = (response.data['meals'] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();

      return Right(meals);
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      return Left(ServerFailure());
    }
  }
}
