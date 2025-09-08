import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/data/theme/shadcn.dart';

import 'info.dart';

class PromptSettingsSpeed extends StatelessWidget {
  const PromptSettingsSpeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PromptSettingsProvider>(
      builder: (context, settings, _) {
        return SizedBox(
          height: 200,
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
                        Icon(LucideIcons.zap, color: ShadcnThemer().secondary()),
                        Row(
                          children: [
                            Text("Speed"),
                            PromptSettingsInfo(
                              "Adjusting the speed of the generated speech is simple. Set the value to 1.0 for normal speed. To make it faster, "
                                  "use a value above 1.0, and to slow it down, use a value below 1.0. Be cautious, as extremely high or low values could "
                                  "negatively impact the speech quality.",
                              icon: LucideIcons.zap,
                            ),
                          ],
                        ),
                      ],
                    ).gap(8),
                    Text(
                      SliderValue.single(
                        settings.speed,
                      ).value.toStringAsFixed(2),
                    ).withMargin(bottom: 5),
                  ],
                ),
                Flexible(
                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Slower",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.gray.shade400,
                              ),
                            ),
                            Text(
                              "Faster",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.gray.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: Slider(
                                value: SliderValue.single(settings.speed),
                                min: 0.7,
                                max: 1.20,
                                increaseStep: 0.01,
                                decreaseStep: 0.01,
                                onChanged: (value) {
                                  settings.setSpeed(value.value);
                                },
                              ),
                            ),
                          ],
                        ).withPadding(vertical: 8),
                      ),
                    ],
                  ).gap(4),
                ),
              ],
            ).gap(14),
          ),
        );
      },
    );
  }
}
