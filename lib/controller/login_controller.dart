import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
