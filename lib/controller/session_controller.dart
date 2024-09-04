import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController extends ChangeNotifier {
  bool _isSessionActive = true;
  bool get isSessionActive => _isSessionActive;

  SessionController() {
    checkSessionTime();
  }

  Future checkSessionTime() async {
    final pref = await SharedPreferences.getInstance();
    final timeOutString = pref.getString("timeOut");
    if (timeOutString != null) {
      final timeOut = DateTime.parse(timeOutString);
      final remainingTime = timeOut.difference(DateTime.now()).inMilliseconds;
      if (remainingTime > 0) {
        await Future.delayed(Duration(milliseconds: remainingTime));
      }
      _isSessionActive = false;
      notifyListeners();
    } else {
      _isSessionActive = false;
      notifyListeners();
    }
  }

  void resetSession(double milliseconds) async {
    _isSessionActive = true;
    notifyListeners();
    checkSessionTime();
  }
}
