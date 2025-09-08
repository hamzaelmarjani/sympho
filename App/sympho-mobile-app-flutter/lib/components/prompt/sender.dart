import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/audio.dart';
import 'package:sympho/classes/tts.dart';
import 'package:sympho/components/ui/toast.dart';
import 'package:sympho/data/theme/shadcn.dart';
import 'package:sympho/provider/data/prompt.dart';
import 'package:sympho/provider/ui/generate.dart';
import 'package:sympho/server/crud.dart';
import 'package:sympho/server/network_state.dart';
import 'package:sympho/storage/generation/common.dart';
import 'package:sympho/storage/generation/tts.dart';
import 'package:uuid/uuid.dart';
import '../../provider/data/audios.dart';
import '../../provider/data/settings.dart';

class PromptSender extends StatefulWidget {
  const PromptSender({super.key});

  @override
  State<PromptSender> createState() => _PromptSenderState();
}

class _PromptSenderState extends State<PromptSender> {
  Future<void> onSent(BuildContext context) async {
    /// Bring all states required to combine an instance of TTSRequest
    /// All those methods should be called before any `async/await` void.

    PromptTextProvider promptTextProvider = Provider.of<PromptTextProvider>(
      context,
      listen: false,
    );

    PromptVoiceProvider voiceProvider = Provider.of<PromptVoiceProvider>(
      context,
      listen: false,
    );

    PromptSettingsProvider settingsProvider =
        Provider.of<PromptSettingsProvider>(context, listen: false);

    GenerateTTSProcessProvider generateTTSProcessProvider =
        Provider.of<GenerateTTSProcessProvider>(context, listen: false);

    GeneratedAudiosProvider generatedAudiosProvider =
        Provider.of<GeneratedAudiosProvider>(context, listen: false);

    if (promptTextProvider.text.length < 10) {
      handleFailedRequest("short-prompt");
      return;
    }

    /// Check if the device is connected to the internet
    if (!(await isConnected(
      doubleCheckStarted: () {
        generateTTSProcessProvider.set(true);
      },
    ))) {
      handleFailedRequest("network-error");
      return;
    }

    /// Combine VoiceSettings instance
    TTSVoiceSettings voiceSettings = TTSVoiceSettings(
      stability: settingsProvider.stability,
      similarityBoost: settingsProvider.similarityBoost,
      style: settingsProvider.style,
      useSpeakerBoost: settingsProvider.useSpeakerBoost,
      speed: settingsProvider.speed,
    );

    /// Combine the TTSRequest instance
    TTSRequest ttsRequest = TTSRequest(
      text: promptTextProvider.text,
      voiceId: voiceProvider.id,
      voiceSettings: voiceSettings,
    );

    /// Block all inputs before send a request
    generateTTSProcessProvider.set(true);

    TTSResponse response = await ServerCrud.requestTTS(request: ttsRequest);

    if (response.audio != null) {
      // TODO create an instance of `GeneratedAudio`
      // TODO you can store it to database in user field or doc, or any place you want
      // TODO we will store it only locally as secure storage, and get it when the app run again.

      var uuid = Uuid();

      GeneratedAudio generatedAudioInstance = GeneratedAudio(
        id: uuid.v4(),
        data: response.audio!,
        request: ttsRequest,
        date: DateTime.now(),
        tool: Tool.tts,
      );

      /// Add GeneratedAudio instance to the Provider state.
      generatedAudiosProvider.add(generatedAudioInstance);

      /// Store the GeneratedAudio instance silently to secure storage.
      storeGeneratedAudio(generatedAudioInstance);

      /// Store the GeneratedAudio instance Id silently to secure storage.
      GenerationIdManager.addGenerationId(generatedAudioInstance.id);
    } else {
      handleFailedRequest(response.error ?? "unknown-error");
    }

    /// Unblock all inputs after the operation ends
    generateTTSProcessProvider.set(false);
  }

  void handleFailedRequest(String errorMessage) {
    late String title;
    late String subtitle;

    switch (errorMessage) {
      case "short-prompt":
        title = "Too short text!";
        subtitle = "Make sure you enter a long enough text for best result.";
        break;
      case "unauthorized-error":
        title = "Un-authorized operation!";
        subtitle =
            "You are not authorized to generate speech, please upgrade your plan.";
        break;
      case "network-error":
        title = "No Network!";
        subtitle =
            "Make sure you are connected to the Internet, then try again.";
        break;
      default:
        title = "Unknown error";
        subtitle = "Something went wrong, please try again later.";
        break;
    }

    displayToast(
      context: context,
      title: title,
      subtitle: subtitle,
      showClose: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateTTSProcessProvider>(
      builder: (context, process, _) {
        return PrimaryButton(
          onPressed: () => onSent(context),
          enabled: !process.onProcess,
          enableFeedback: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Generate speech"),
              process.onProcess
                  ? CircularProgressIndicator(
                      color: ShadcnThemer().shadcnTheme.colorScheme.background,
                    )
                  : Icon(LucideIcons.sparkles),
            ],
          ).gap(12),
        );
      },
    );
  }
}
