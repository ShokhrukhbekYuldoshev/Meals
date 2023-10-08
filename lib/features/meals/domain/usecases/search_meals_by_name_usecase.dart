import 'package:dartz/dartz.dart';
import 'package:meals/core/errors/failures.dart';
import 'package:meals/core/usecases/usecase.dart';

import 'package:meals/features/meals/domain/entities/meal_entity.dart';
import 'package:meals/features/meals/domain/repositories/meal_repository.dart';

class SearchMealsByNameUseCase extends UseCase<List<MealEntity>, String> {
  final MealRepository repository;

  SearchMealsByNameUseCase(this.repository);

  @override
  Future<Either<Failure, List<MealEntity>>> call(params) async {
    return await repository.searchMealsByName(params);
  }
}
