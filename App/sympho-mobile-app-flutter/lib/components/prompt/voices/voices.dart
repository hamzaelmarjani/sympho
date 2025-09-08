import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/voice.dart';
import 'package:sympho/components/prompt/voices/voice_stack.dart';
import 'package:sympho/data/voices/voices.dart';
import 'package:sympho/provider/data/prompt.dart';
import 'package:sympho/provider/ui/generate.dart';

class PromptVoices extends StatelessWidget {
  const PromptVoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateTTSProcessProvider>(
        builder: (context, process, _) {
        return Consumer<PromptVoiceProvider>(
          builder: (context, voice, _) {
            final targetVoice =
                allVoices.firstWhereOrNull((v) => v.id == voice.id) ??
                allVoices.first;

            return OutlineButton(
              enableFeedback: false,
              onPressed: () {
                showPromptVoicesList(context);
              },
              enabled: !process.onProcess,
              child: Text(
                "${targetVoice.gender == VoiceGender.male ? "👨" : "👩"}  ${targetVoice.name}",
              ),
            );
          },
        );
      }
    );
  }
}

void showPromptVoicesList(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  openSheet(
    context: context,
    position: OverlayPosition.bottom,
    draggable: true,
    builder: (context) {
      return SizedBox(
        height: screenSize.height * 0.7,
        width: screenSize.width,
        child: PromptVoice(),
      );
    },
  );
}
