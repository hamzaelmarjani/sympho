enum VoiceGender { male, female, all }

class Voice {
  final String id;
  final String name;
  final VoiceGender gender;
  final bool isPro;
  final DateTime date;

  Voice({
    required this.id,
    required this.name,
    required this.gender,
    required this.isPro,
    required this.date,
  });
}

class VoiceSettings {
  final double speed;
  final int stability;
  final int similarity;
  final int exaggeration;

  VoiceSettings({
    required this.speed,
    required this.stability,
    required this.similarity,
    required this.exaggeration,
  });
}
