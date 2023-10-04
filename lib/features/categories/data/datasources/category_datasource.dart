import 'package:dio/dio.dart';
import 'package:meals/core/network/network_service.dart';

class CategoryDatasource {
  final NetworkService networkService;

  CategoryDatasource(this.networkService);

  Future<Response> fetchCategories() async {
    const url = '/categories.php';
    return await networkService.getRequest(url);
  }
}
