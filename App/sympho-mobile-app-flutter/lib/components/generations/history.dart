import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/audio.dart';
import 'package:sympho/components/generations/player/player.dart'
    show GenerationsAudioPlayer;
import 'package:sympho/provider/data/audios.dart';

class GenerationsHistory extends StatelessWidget {
  const GenerationsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneratedAudiosProvider>(
      builder: (context, generatedAudios, _) {
        return OutlineButton(
          onPressed: () async {
            generatedAudios.setIsHistoryOpened(true);
            openSheet(
              context: context,
              position: OverlayPosition.bottom,
              draggable: false,
              barrierDismissible: false,
              builder: (context) {
                return GenerationsAudiosHistory();
              },
            );
          },
          density: ButtonDensity.icon,
          enableFeedback: false,
          size: ButtonSize.small,
          child: const Icon(LucideIcons.history),
        );
      },
    );
  }
}

void openGenerationsAudiosHistoryShared(BuildContext context) {
  openSheet(
    context: context,
    position: OverlayPosition.bottom,
    draggable: false,
    barrierDismissible: false,
    builder: (context) {
      return GenerationsAudiosHistory();
    },
  );
}

class GenerationsAudiosHistory extends StatelessWidget {
  const GenerationsAudiosHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      child: SizedBox(
        height: screenSize.height * 0.85,
        width: screenSize.width,
        child: Consumer<GeneratedAudiosProvider>(
          builder: (context, generatedAudios, _) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Generations (${generatedAudios.audios.length})"),
                    IconButton.outline(
                      size: ButtonSize.small,
                      enableFeedback: false,
                      onPressed: () {
                        generatedAudios.setCurrentPlayingId("NONE");
                        generatedAudios.setIsHistoryOpened(false);
                        closeSheet(context);
                      },
                      icon: Icon(LucideIcons.x),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: generatedAudios.audios.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (_, index) {
                      GeneratedAudio audio = generatedAudios.audios[index];
                      return GenerationsAudioPlayer(
                        isHistoryOpened: generatedAudios.isHistoryOpened,
                        audioInstance: audio,
                        requestedFromHistory: true,
                        currentPlayerId: generatedAudios.currentPlayingId,
                        setCurrentPlayerId: (id) {
                          generatedAudios.setCurrentPlayingId(id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ).gap(20).withPadding(all: 12);
          },
        ),
      ),
    );
  }
}
