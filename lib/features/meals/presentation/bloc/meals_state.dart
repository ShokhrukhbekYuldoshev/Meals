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
