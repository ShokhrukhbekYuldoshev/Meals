import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'network_info.dart';

class NetworkService {
  final Dio _dio;
  final NetworkInfo networkInfo;

  NetworkService(this.networkInfo)
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
          ),
        );

  Future<Response> getRequest(String url) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        // Handle network not available case, you can throw an exception or return an error response.
        throw DioException(
          message: 'No internet connection',
          requestOptions: RequestOptions(path: url),
        );
      }

      final response = await _dio.get(url);
      return response;
    } catch (error) {
      throw DioException(
        message: 'Something went wrong',
        requestOptions: RequestOptions(path: url),
      );
    }
  }
}
