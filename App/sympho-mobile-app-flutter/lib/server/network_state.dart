import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

/// Check if the device is connected to at-least one network
Future<bool> isConnected({required Function doubleCheckStarted}) async {
  bool isConnected = false;

  final List<ConnectivityResult> connectivityResult = await (Connectivity()
      .checkConnectivity());

  debugPrint(connectivityResult.toString());

  if (connectivityResult.contains(ConnectivityResult.none) &&
      connectivityResult.length == 1) {
    isConnected = false;
  }

  /// Sometimes the plugin return not connected even the device/simulator is connected to internet.
  /// We will take 3 seconds 'maximum' from the time of the user to double check.
  if (!isConnected) {
    doubleCheckStarted();
    final result = await InternetAddress.lookup(
      'google.com',
    ).timeout(Duration(seconds: 3));
    if (result.isEmpty || result[0].rawAddress.isEmpty) {
      return false;
    }
  }
  return true;
}
