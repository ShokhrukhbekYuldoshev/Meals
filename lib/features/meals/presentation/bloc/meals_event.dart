part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();

  @override
  List<Object> get props => [];
}

class GetMealsByQuery extends MealsEvent {
  final String query;

  const GetMealsByQuery(this.query);

  @override
  List<Object> get props => [query];
}

class GetMealById extends MealsEvent {
  final String id;

  const GetMealById(this.id);

  @override
  List<Object> get props => [id];
}

class ListMealsByFirstLetter extends MealsEvent {
  final String letter;

  const ListMealsByFirstLetter(this.letter);

  @override
  List<Object> get props => [letter];
}

class LookupRandomMeal extends MealsEvent {}

class SearchMealsByName extends MealsEvent {
  final String name;

  const SearchMealsByName(this.name);

  @override
  List<Object> get props => [name];
}
