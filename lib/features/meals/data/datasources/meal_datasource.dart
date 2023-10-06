import 'package:dio/dio.dart';
import 'package:meals/core/network/network_service.dart';

class MealDatasource {
  final NetworkService networkService;

  MealDatasource(this.networkService);

  Future<Response> fetchMealsByQuery(String query) async {
    final String url = '/filter.php?$query';

    final response = await networkService.getRequest(url);
    return response;
  }

  Future<Response> fetchMealById(String id) async {
    final String url = '/lookup.php?i=$id';

    final response = await networkService.getRequest(url);
    return response;
  }
}
