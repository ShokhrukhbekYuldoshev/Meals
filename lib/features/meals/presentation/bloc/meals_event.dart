part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();

  @override
  List<Object> get props => [];
}

class FetchMealsByQuery extends MealsEvent {
  final String query;

  const FetchMealsByQuery(this.query);

  @override
  List<Object> get props => [query];
}
