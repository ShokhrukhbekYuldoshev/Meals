import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meals/core/di/injector.dart';
import 'package:meals/features/meals/domain/entities/meal_entity.dart';
import 'package:meals/features/meals/domain/usecases/get_meal_list_usecase.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  MealsBloc({required GetMealListUseCase getMealsUsecase})
      : super(MealsInitial()) {
    on<FetchMealsByQuery>((event, emit) async {
      emit(MealsLoading());
      final result = await sl<GetMealListUseCase>().call(event.query);

      result.fold(
        (failure) => emit(MealsError(failure.toString())),
        (meals) => emit(MealsLoaded(meals)),
      );
    });
  }
}
