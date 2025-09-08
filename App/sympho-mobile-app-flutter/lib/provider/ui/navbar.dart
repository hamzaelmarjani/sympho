import 'package:flutter/material.dart';

class NavbarProvider extends ChangeNotifier {
  int index = 0;

  void set(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void reset() {
    index = 0;
    notifyListeners();
  }
}
