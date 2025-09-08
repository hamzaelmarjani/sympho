import "dart:typed_data";

class TTSRequest {
  final String text;
  final String voiceId;
  final TTSVoiceSettings voiceSettings;

  TTSRequest({
    required this.text,
    required this.voiceId,
    required this.voiceSettings,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'voiceId': voiceId,
      "voiceSettings": voiceSettings.toMap(),
    };
  }
}

class TTSVoiceSettings {
  final double stability;
  final double similarityBoost;
  final double style;
  final bool useSpeakerBoost;
  final double speed;

  TTSVoiceSettings({
    required this.stability,
    required this.similarityBoost,
    required this.style,
    required this.useSpeakerBoost,
    required this.speed,
  });

  Map<String, dynamic> toMap() {
    return {
      'stability': stability,
      'similarityBoost': similarityBoost,
      'style': style,
      'useSpeakerBoost': useSpeakerBoost,
      'speed': speed,
    };
  }
}

class TTSResponse {
  Uint8List? audio;
  String? error;

  TTSResponse({this.audio, this.error});
}
