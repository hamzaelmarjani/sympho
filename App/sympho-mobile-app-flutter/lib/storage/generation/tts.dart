import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sympho/classes/audio.dart';
import 'package:sympho/classes/tts.dart';
import 'package:sympho/storage/secure.dart';

/// Store the generated audio on 3 steps:
/// 1. create a Map from the generated instance
/// 2. store the Map to the system secure storage
/// 3. add the instance ID to the list of stored instances
Future<void> storeGeneratedAudio(GeneratedAudio instance) async {
  try {
    Map<String, dynamic> instanceAsMap = {
      "id": instance.id,
      "request": instance.request.toMap(),
      'date': instance.date.toIso8601String(),
      "data": instance.data,
      "tool": instance.tool.name,
    };
    await SecureStorageCrud().write(instance.id, instanceAsMap);
  } catch (err) {
    debugPrint(err.toString());
  }
}

/// get the stored generated audio on 3 steps:
/// 1. read the stored Map, find it by the generated audio id.
/// 2. decode the Map and combine the `GeneratedAudio` instance
Future<GeneratedAudio?> getGeneratedAudio(String id) async {
  try {
    Map<String, dynamic>? instanceAsMap = await SecureStorageCrud().read(id);

    if (instanceAsMap != null) {
      try {
        final requestMap = instanceAsMap["request"];
        final voiceSettingsMap = instanceAsMap["request"]["voiceSettings"];
        GeneratedAudio instance = GeneratedAudio(
          id: id,
          data: Uint8List.fromList(
            (instanceAsMap["data"] as List)
                .map((e) => int.parse(e.toString()))
                .toList(),
          ),
          date: DateTime.parse(instanceAsMap["date"].toString()),
          tool: instanceAsMap["tool"].toString() == "tts" ? Tool.tts : Tool.tts,
          request: TTSRequest(
            text: requestMap['text'].toString(),
            voiceId: requestMap["voiceId"].toString(),
            voiceSettings: TTSVoiceSettings(
              stability: double.parse(voiceSettingsMap['stability'].toString()),
              similarityBoost: double.parse(
                voiceSettingsMap['similarityBoost'].toString(),
              ),
              style: double.parse(voiceSettingsMap['style'].toString()),
              useSpeakerBoost:
                  voiceSettingsMap['useSpeakerBoost'].toString() == "true",
              speed: double.parse(voiceSettingsMap['speed'].toString()),
            ),
          ),
        );

        /// return the `GeneratedAudio` instance only if decoding of Map is succeed.
        return instance;
      } catch (err) {
        debugPrint("Error Combine Instance $err");
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }

  return null;
}
