import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:meals/core/network/network_service.dart';
import 'package:meals/features/categories/data/datasources/category_datasource.dart';
import 'package:meals/features/categories/data/repositories/category_repository_impl.dart';
import 'package:meals/features/categories/domain/repositories/category_repository.dart';
import 'package:meals/features/categories/domain/usecases/get_category_list_usecase.dart';
import 'package:meals/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:meals/features/meals/data/datasources/meal_datasource.dart';
import 'package:meals/features/meals/data/repositories/meal_repository_impl.dart';
import 'package:meals/features/meals/domain/repositories/meal_repository.dart';
import 'package:meals/features/meals/domain/usecases/get_meal_by_id_usecase.dart';
import 'package:meals/features/meals/domain/usecases/get_meal_list_usecase.dart';
import 'package:meals/features/meals/domain/usecases/list_meals_by_first_letter_usecase.dart';
import 'package:meals/features/meals/domain/usecases/lookup_random_meal_usecase.dart';
import 'package:meals/features/meals/domain/usecases/search_meals_by_name_usecase.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';

import '../constants/assets.dart';
import '../errors/failures.dart';
import '../network/network_info.dart';
import '../router/app_router.dart';
import '../themes/app_theme.dart';
import '../utils/input_converter.dart';

final sl = GetIt.instance;

void init() {
  // ================================================================
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => NetworkService(sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => AppTheme());
  sl.registerLazySingleton(() => Assets());

  // Utils
  sl.registerLazySingleton(() => InputConverter());

  // Errors
  sl.registerLazySingleton<Failure>(
    () => ServerFailure(),
    instanceName: 'server',
  );
  sl.registerLazySingleton<Failure>(
    () => CacheFailure(),
    instanceName: 'cache',
  );

  // ================================================================
  // Features - Categories

  // Datasources
  sl.registerLazySingleton(() => CategoryDatasource(sl()));
  // Usecases
  sl.registerLazySingleton(() => GetCategoryListUseCase(sl()));
  // Repository
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(sl()));

  // Bloc
  sl.registerFactory(
    () => CategoriesBloc(
      getCategoriesUsecase: sl(),
    ),
  );

  // ================================================================
  // Features - Meals

  // Datasources
  sl.registerLazySingleton(() => MealDatasource(sl()));

  // Usecases
  sl.registerLazySingleton(() => GetMealListUseCase(sl()));
  sl.registerLazySingleton(() => GetMealByIdUseCase(sl()));
  sl.registerLazySingleton(() => ListMealsByFirstLetterUseCase(sl()));
  sl.registerLazySingleton(() => LookupRandomMealUseCase(sl()));
  sl.registerLazySingleton(() => SearchMealsByNameUseCase(sl()));

  // Repository
  sl.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(
      sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => MealsBloc(
      getMealsUsecase: sl(),
    ),
  );
}
