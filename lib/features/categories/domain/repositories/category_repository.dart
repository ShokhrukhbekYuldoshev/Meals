import 'package:meals/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meals/features/categories/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
