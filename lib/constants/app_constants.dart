import 'package:flutter/material.dart';

class AppConstants {
  static const apiBaseUrl = "https://mock-api.zoft.care/";
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
