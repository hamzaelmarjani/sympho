import 'package:flutter/material.dart';

class GenerateTTSProcessProvider extends ChangeNotifier {
  bool onProcess = false;

  void set(bool s) {
    onProcess = s;
    notifyListeners();
  }
}
