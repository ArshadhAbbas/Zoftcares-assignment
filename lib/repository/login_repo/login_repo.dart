import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoftcares/constants/dio_client.dart';
import 'package:zoftcares/models/user.dart';
import 'package:zoftcares/models/version.dart';
import 'package:zoftcares/view/login/view/login_view.dart';

class LoginRepo {
  Future<AuthenticatedUser> login(String email, String password) async {
    try {
      Response response = await DioClient.dioClient
          .post("login", data: {"email": email, "password": password});
      final data = AuthenticatedUser.fromMap(response.data);
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      } else {
        throw Exception(e);
      }
    }
  }

  Future logOut(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    await Navigator.pushNamedAndRemoveUntil(
        context, LoginView.routePath, (route) => false);
  }

  Future<VersionModel> getVersion() async {
    try {
      Response response = await DioClient.dioClient.get("version");
      final data = VersionModel.fromMap(response.data);
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      } else {
        throw Exception(e);
      }
    }
  }
}

class AuthTimer {
  late Timer _timer;
  void runAuthTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _timer.cancel();
    });
  }
}
