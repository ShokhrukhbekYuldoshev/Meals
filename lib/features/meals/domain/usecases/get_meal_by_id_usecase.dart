import 'package:dartz/dartz.dart';
import 'package:meals/core/errors/failures.dart';
import 'package:meals/core/usecases/usecase.dart';

import 'package:meals/features/meals/domain/entities/meal_entity.dart';
import 'package:meals/features/meals/domain/repositories/meal_repository.dart';

class GetMealByIdUseCase extends UseCase<MealEntity, String> {
  final MealRepository repository;

  GetMealByIdUseCase(this.repository);

  @override
  Future<Either<Failure, MealEntity>> call(params) async {
    return await repository.getMealsById(params);
  }
}
