import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/data/theme/shadcn.dart';
import 'info.dart';

class PromptSettingsStability extends StatelessWidget {
  const PromptSettingsStability({super.key});

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
                          LucideIcons.scale,
                          color: ShadcnThemer().secondary(),
                        ),
                        Row(
                          children: [
                            Text("Stability"),
                            PromptSettingsInfo(
                              "More Stability makes the voice consistent, "
                              "but can sound monotone. For longer texts, "
                              "we recommend lowering this value. Should be one the following values: 0.0 | 0.5 | 1.0",
                              icon: LucideIcons.scale,
                            ),
                          ],
                        ),
                      ],
                    ).gap(8),
                    Text(
                      SliderValue.single(
                        settings.stability,
                      ).value.toStringAsFixed(1),
                    ).withMargin(bottom: 5),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Slider(
                          value: SliderValue.single(settings.stability),
                          min: 0.0,
                          max: 1.0,
                          increaseStep: 0.1,
                          decreaseStep: 0.1,
                          onChanged: (value) {
                            settings.setStability(value.value);
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
