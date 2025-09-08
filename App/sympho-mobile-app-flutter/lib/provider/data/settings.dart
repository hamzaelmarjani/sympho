import 'package:flutter/material.dart';

class PromptSettingsProvider extends ChangeNotifier {
  double stability = 0.5;
  double similarityBoost = 0.75;
  double style = 0.0;
  bool useSpeakerBoost = true;
  double speed = 1.0;

  void setStability(double v) {
    stability = v;
    notifyListeners();
  }

  void setSimilarityBoost(double v) {
    similarityBoost = v;
    notifyListeners();
  }

  void setStyle(double v) {
    style = v;
    notifyListeners();
  }

  void setUseSpeakerBoost(bool s) {
    useSpeakerBoost = s;
    notifyListeners();
  }

  void setSpeed(double v) {
    speed = v;
    notifyListeners();
  }

  void reset() {
    speed = 1.0;
    stability = 0.5;
    similarityBoost = 0.75;
    style = 0.0;
    useSpeakerBoost = true;
    notifyListeners();
  }
}
