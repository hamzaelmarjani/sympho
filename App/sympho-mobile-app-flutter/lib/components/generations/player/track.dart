import 'package:auto_size_text/auto_size_text.dart' show AutoSizeText;
import 'package:flutter/material.dart';
import 'package:sympho/data/theme/shadcn.dart';

class GenerationsPlayerTrack extends StatelessWidget {
  final Duration audioDuration;
  final Duration currentDuration;
  final Function(double) onChange;

  const GenerationsPlayerTrack({
    super.key,
    required this.audioDuration,
    required this.currentDuration,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    double trackValue = currentDuration.inMilliseconds == 0
        ? 0
        : (currentDuration.inMilliseconds * 100) / audioDuration.inMilliseconds;

    return Column(
      spacing: 14,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 16,
              child: AutoSizeText(
                formatAudioDuration(currentDuration),
                style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 16,
              child: AutoSizeText(
                formatAudioDuration(audioDuration),
                style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                maxLines: 1,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: ShadcnThemer().primary(),
            inactiveTrackColor: Colors.grey.shade800,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
          ),
          child: Slider(
            padding: EdgeInsets.zero,
            value: trackValue.clamp(0, 100),
            min: 0,
            max: 100,
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}

String formatAudioDuration(Duration duration) {
  int totalSeconds = duration.inSeconds;
  int minutes = totalSeconds ~/ 60;
  int seconds = totalSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}
