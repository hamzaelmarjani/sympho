import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/data/theme/shadcn.dart';
import 'info.dart';

class PromptSettingsSimilarity extends StatelessWidget {
  const PromptSettingsSimilarity({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PromptSettingsProvider>(
      builder: (context, settings, _) {
        return SizedBox(
          height: 160,
          child: Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          LucideIcons.layers2,
                          color: ShadcnThemer().secondary(),
                        ),
                        Row(
                          children: [
                            Text("Similarity Boost"),
                            PromptSettingsInfo(
                              "High enhancement boosts overall voice clarity and target speaker similarity. "
                                  "Very high values can cause artifacts, "
                                  "so adjusting this setting to find the optimal value is encouraged.",
                              icon: LucideIcons.layers2,
                            ),
                          ],
                        ),
                      ],
                    ).gap(8),
                    Text(
                      SliderValue.single(
                        settings.similarityBoost,
                      ).value.toStringAsFixed(1),
                    ).withMargin(bottom: 5),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Slider(
                          value: SliderValue.single(settings.similarityBoost),
                          min: 0.0,
                          max: 1.0,
                          increaseStep: 0.1,
                          decreaseStep: 0.1,
                          onChanged: (value) {
                            settings.setSimilarityBoost(value.value);
                          },
                        ),
                      ),
                    ],
                  ).withPadding(vertical: 8),
                ),
              ],
            ).gap(14),
          ),
        );
      },
    );
  }
}
