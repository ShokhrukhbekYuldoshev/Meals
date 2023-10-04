import 'package:meals/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meals/features/categories/data/datasources/category_datasource.dart';
import 'package:meals/features/categories/data/models/category_model.dart';
import 'package:meals/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource categoryDatasource;

  CategoryRepositoryImpl(this.categoryDatasource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await categoryDatasource.fetchCategories();
      final categories = (response.data['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
