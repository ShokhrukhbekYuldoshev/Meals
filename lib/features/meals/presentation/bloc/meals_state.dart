part of 'meals_bloc.dart';

abstract class MealsState extends Equatable {
  const MealsState();

  @override
  List<Object> get props => [];
}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<MealEntity> meals;

  const MealsLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealsError extends MealsState {
  final String message;

  const MealsError(this.message);

  @override
  List<Object> get props => [message];
}

class MealLoaded extends MealsState {
  final MealEntity meal;

  const MealLoaded(this.meal);

  @override
  List<Object> get props => [meal];
}

class RandomMealLoaded extends MealsState {
  final MealEntity meal;

  const RandomMealLoaded(this.meal);

  @override
  List<Object> get props => [meal];
}
