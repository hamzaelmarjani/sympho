import 'package:flutter/material.dart';
import 'package:sympho/classes/voice.dart';
import 'package:sympho/data/voices/voices.dart';

class PromptTextProvider extends ChangeNotifier {
  String text = "";

  void set(String v) {
    text = v;
    notifyListeners();
  }

  void reset() {
    text = "";
    notifyListeners();
  }
}

class PromptVoiceProvider extends ChangeNotifier {
  /// Default to the first Free voice,
  /// You can set the default voice ID from `allVoices` list.
  String id = allVoices.where((v) => !v.isPro).first.id;

  void set(String v) {
    id = v;
    notifyListeners();
  }

  void reset() {
    id = "";
    notifyListeners();
  }
}

class PromptVoiceGenderFilterProvider extends ChangeNotifier {
  VoiceGender gender = VoiceGender.all;

  void set(VoiceGender g) {
    gender = g;
    notifyListeners();
  }

  void reset() {
    gender = VoiceGender.all;
    notifyListeners();
  }
}
