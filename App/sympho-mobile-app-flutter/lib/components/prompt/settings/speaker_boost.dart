import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/data/theme/shadcn.dart';
import 'info.dart';

class PromptSettingsSpeakerBoost extends StatelessWidget {
  const PromptSettingsSpeakerBoost({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PromptSettingsProvider>(
      builder: (context, settings, _) {
        return SizedBox(
          height: 110,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      LucideIcons.speaker,
                      color: ShadcnThemer().secondary(),
                    ),
                    Row(
                      children: [
                        Text("Speaker Boost"),
                        PromptSettingsInfo(
                          "By boosting the similarity, you can achieve a more accurate and faithful voice clone. "
                          "However, this comes at the cost of a slower generation speed.",
                          icon: LucideIcons.speaker,
                        ),
                      ],
                    ),
                  ],
                ).gap(8),
                Switch(
                  value: settings.useSpeakerBoost,
                  onChanged: (value) {
                    settings.setUseSpeakerBoost(value);
                  },
                ).withMargin(bottom: 5),
              ],
            ).gap(14),
          ),
        );
      },
    );
  }
}
