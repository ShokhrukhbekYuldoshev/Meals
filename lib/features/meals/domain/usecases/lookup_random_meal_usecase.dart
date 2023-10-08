import 'package:dartz/dartz.dart';
import 'package:meals/core/errors/failures.dart';
import 'package:meals/core/usecases/no_params.dart';
import 'package:meals/core/usecases/usecase.dart';

import 'package:meals/features/meals/domain/entities/meal_entity.dart';
import 'package:meals/features/meals/domain/repositories/meal_repository.dart';

class LookupRandomMealUseCase extends UseCase<MealEntity, NoParams> {
  final MealRepository repository;

  LookupRandomMealUseCase(this.repository);

  @override
  Future<Either<Failure, MealEntity>> call(NoParams params) async {
    return await repository.lookupRandomMeal();
  }
}
