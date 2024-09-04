import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoftcares/constants/dio_client.dart';
import 'package:zoftcares/models/posts_model.dart';

class PostsRepo {
  Future<PostsModel> getPosts({required int pageIndex}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await DioClient.dioClient.get(
          "posts?page=$pageIndex&size=10",
          options:
              Options(headers: {"x-auth-key": prefs.getString("accessToken")}));
      final data = PostsModel.fromMap(response.data);
      return data;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      } else {
        throw Exception(error);
      }
    }
  }
}
