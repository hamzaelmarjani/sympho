import 'package:sympho/classes/voice.dart';
import 'package:sympho/data/voices/female.dart';
import 'package:sympho/data/voices/male.dart';

final List<Voice> allVoices = [...maleVoices, ...femaleVoices]
  ..sort((a, b) => a.name.compareTo(b.name));
