import 'package:dartz/dartz.dart';
import 'package:meals/core/errors/failures.dart';
import 'package:meals/core/usecases/no_params.dart';
import 'package:meals/core/usecases/usecase.dart';
import 'package:meals/features/categories/domain/entities/category_entity.dart';
import 'package:meals/features/categories/domain/repositories/category_repository.dart';

class GetCategoryListUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository repository;

  GetCategoryListUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
