import 'package:flutter/cupertino.dart';
import 'package:sympho/classes/audio.dart';
import 'package:sympho/storage/generation/common.dart';
import 'package:sympho/storage/generation/tts.dart';

class GeneratedAudiosProvider extends ChangeNotifier {
  List<GeneratedAudio> audios = [];
  String currentPlayingId = "NONE";
  bool isHistoryOpened = false;

  void setCurrentPlayingId(String c) {
    currentPlayingId = c;
    notifyListeners();
  }

  void setIsHistoryOpened(bool s) {
    isHistoryOpened = s;
    notifyListeners();
  }

  void init(List<GeneratedAudio> l) {
    audios = l;
    notifyListeners();
  }

  void add(GeneratedAudio a) {
    audios.add(a);
    notifyListeners();
  }

  void remove(String id) {
    audios.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void update(GeneratedAudio u) {
    final i = audios.indexWhere((a) => a.id == u.id);
    if (i != -1) {
      audios[i] = u;
      notifyListeners();
    }
  }

  Future<void> collectGeneratedAudios() async {
    List<String> ids = await GenerationIdManager.getAllGenerationIds();

    if (ids.isNotEmpty) {
      for (final id in ids) {
        GeneratedAudio? instance = await getGeneratedAudio(id);
        if (instance != null) {
          add(instance);
        }
      }
    }
  }
}
