import 'package:flutter/material.dart';

extension WidgetExtensions on BuildContext {
  void showSnackbarExtension(String matter) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(matter)));
  }
}
