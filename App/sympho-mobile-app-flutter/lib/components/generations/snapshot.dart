import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/audio.dart';
import 'package:sympho/components/generations/player/player.dart';
import 'package:sympho/provider/data/audios.dart';
import 'history.dart';

class GenerationsSnapshot extends StatelessWidget {
  const GenerationsSnapshot({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Consumer<GeneratedAudiosProvider>(
        builder: (context, generatedAudios, _) {
          List<GeneratedAudio> sortedGeneratedAudios = [
            ...generatedAudios.audios,
          ]..sort((a, b) => b.date.compareTo(a.date));

          return generatedAudios.audios.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: generatedAudios.audios.length > 1
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children:
                            (generatedAudios.audios.length > 1
                                    ? (sortedGeneratedAudios..take(2))
                                    : generatedAudios.audios.take(1))
                                .take(2)
                                .map((audio) => generationsSnapshotAudio(audio))
                                .toList(),
                      ),
                      generatedAudios.audios.isNotEmpty
                          ? OutlineButton(
                              size: ButtonSize.small,
                              onPressed: () {
                                openGenerationsAudiosHistoryShared(context);
                              },
                              enableFeedback: false,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Open all generations"),
                                  Icon(LucideIcons.history),
                                ],
                              ).gap(12),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ).gap(20),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}

Widget generationsSnapshotAudio(GeneratedAudio audio) {
  return Consumer<GeneratedAudiosProvider>(
    builder: (context, generatedAudios, _) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width / 2) - 16,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: GenerationsAudioPlayer(
            audioInstance: audio,
            requestedFromHistory: false,
            currentPlayerId: generatedAudios.currentPlayingId,
            isHistoryOpened: generatedAudios.isHistoryOpened,
            setCurrentPlayerId: (id) {
              generatedAudios.setCurrentPlayingId(id);
            },
          ),
        ),
      );
    },
  );
}
