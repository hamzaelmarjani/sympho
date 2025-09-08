import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/data/theme/shadcn.dart';

import 'info.dart';

class PromptSettingsStyle extends StatelessWidget {
  const PromptSettingsStyle({super.key});

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
                          LucideIcons.venetianMask,
                          color: ShadcnThemer().secondary(),
                        ),
                        Row(
                          children: [
                            Text("Style Exaggeration"),
                            PromptSettingsInfo(
                              "To make the speech more expressive and exaggerated than the original audio, "
                                  "use higher values. Just know that this can make the speech less stable. "
                                  "To increase the speed of generation, the default value of 0.0 is recommended.",
                              icon: LucideIcons.venetianMask,
                            ),
                          ],
                        ),
                      ],
                    ).gap(8),
                    Text(
                      SliderValue.single(
                        settings.style,
                      ).value.toStringAsFixed(1),
                    ).withMargin(bottom: 5),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Slider(
                          value: SliderValue.single(settings.style),
                          min: 0.0,
                          max: 1.0,
                          increaseStep: 0.1,
                          decreaseStep: 0.1,
                          onChanged: (value) {
                            settings.setStyle(value.value);
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
