import 'dart:typed_data';

import 'package:sympho/classes/tts.dart';

enum Tool { tts }

class GeneratedAudio {
  final String id;
  final Uint8List data;
  final TTSRequest request;
  final DateTime date;
  final Tool tool;

  GeneratedAudio({
    required this.id,
    required this.data,
    required this.request,
    required this.date,
    required this.tool,
  });
}
