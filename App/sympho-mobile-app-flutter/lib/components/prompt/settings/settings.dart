import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/components/prompt/settings/similarity.dart';
import 'package:sympho/components/prompt/settings/speaker_boost.dart';
import 'package:sympho/components/prompt/settings/speed.dart';
import 'package:sympho/components/prompt/settings/stability.dart';
import 'package:sympho/components/prompt/settings/style.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/provider/ui/generate.dart';

class PromptSettings extends StatelessWidget {
  const PromptSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateTTSProcessProvider>(
        builder: (context, process, _) {
        return Consumer<PromptSettingsProvider>(
          builder: (context, settings, _) {
            return OutlineButton(
              enableFeedback: false,
              onPressed: () {
                showPromptSettingsList(context);
              },
              enabled: !process.onProcess,
              child: Icon(LucideIcons.settings2),
            );
          },
        );
      }
    );
  }
}

void showPromptSettingsList(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  openSheet(
    context: context,
    position: OverlayPosition.bottom,
    draggable: true,
    builder: (context) {
      return SizedBox(
        height: screenSize.height * 0.75,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PromptSettingsStability(),
              PromptSettingsSimilarity(),
              PromptSettingsStyle(),
              PromptSettingsSpeakerBoost(),
              PromptSettingsSpeed(),
            ],
          ).gap(12).withPadding(horizontal: 12),
        ),
      );
    },
  );
}
