import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider with ChangeNotifier {
  Connectivity connectivity = Connectivity();

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  startMonitoring() async {
    connectivity.onConnectivityChanged.listen((result) async {
      if (result.contains(ConnectivityResult.none)) {
        _isOnline = false;
        notifyListeners();
      } else {
        await updateConnectionStatus().then((bool isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await connectivity.checkConnectivity();
      if (status.contains(ConnectivityResult.none)) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = false;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> updateConnectionStatus() async {
    late bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }
}
