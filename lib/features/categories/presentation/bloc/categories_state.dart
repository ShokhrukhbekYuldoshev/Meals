part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
