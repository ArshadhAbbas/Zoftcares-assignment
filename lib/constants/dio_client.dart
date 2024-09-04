import 'package:dio/dio.dart';
import 'package:zoftcares/constants/app_constants.dart';

class DioClient {
  static Dio dioClient = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30)));
}
