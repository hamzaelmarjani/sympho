import 'package:just_audio/just_audio.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/audio.dart';
import 'package:sympho/components/generations/player/prompt.dart';
import 'package:sympho/components/generations/player/save.dart';
import 'package:sympho/components/generations/player/share.dart';
import 'package:sympho/components/generations/player/track.dart';

class GenerationsAudioPlayer extends StatefulWidget {
  final String currentPlayerId;
  final Function(String) setCurrentPlayerId;
  final GeneratedAudio audioInstance;
  final bool isHistoryOpened;
  final bool requestedFromHistory;

  const GenerationsAudioPlayer({
    super.key,
    required this.audioInstance,
    required this.currentPlayerId,
    required this.setCurrentPlayerId,
    required this.isHistoryOpened,
    required this.requestedFromHistory,
  });

  @override
  State<GenerationsAudioPlayer> createState() => _GenerationsAudioPlayerState();
}

class _GenerationsAudioPlayerState extends State<GenerationsAudioPlayer> {
  AudioPlayer player = AudioPlayer();

  bool isLoading = true;
  bool hasError = false;

  Duration audioDuration = Duration.zero;
  Duration currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Duration? playerDur = await player.setAudioSource(
        GenerationsPlayerSource(bytes: widget.audioInstance.data),
      );
      isLoading = false;
      audioDuration = playerDur ?? Duration.zero;
    });

    player.positionStream.listen((duration) {
      currentDuration = duration;
      setState(() {});
    });

    player.playerStateStream.listen((state) {
      if (mounted) {
        if (state.processingState == ProcessingState.completed) {
          player.stop().then((_) {
            player.seek(Duration.zero);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _stopCurrentAudio();
    super.dispose();
  }

  @override
  void didUpdateWidget(GenerationsAudioPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isHistoryOpened && !widget.requestedFromHistory) {
      player.pause();
      return;
    }

    if (widget.currentPlayerId != widget.audioInstance.id) {
      player.pause();
    }
  }

  Future<void> _stopCurrentAudio() async {
    if (widget.audioInstance.id == widget.currentPlayerId) {
      widget.setCurrentPlayerId("NONE");
      if (player.playing) {
        player.stop();
      }
    }
  }

  Future<void> playAudio() async {
    try {
      if (widget.currentPlayerId != widget.audioInstance.id) {
        widget.setCurrentPlayerId(widget.audioInstance.id);
        await player.play();
      } else {
        if (player.playing) {
          await player.pause();
        } else {
          await player.play();
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outline(
                      size: ButtonSize.small,
                      enableFeedback: false,
                      icon: Icon(
                        player.playing ? LucideIcons.pause : LucideIcons.play,
                      ),
                      onPressed: playAudio,
                    ),
                    Row(
                      children: [
                        GenerationsAudioSaveToFiles(
                          audioData: widget.audioInstance.data,
                        ),
                        GenerationsAudioShare(
                          audioData: widget.audioInstance.data,
                        ),
                      ],
                    ).gap(12),
                  ],
                ).gap(12),
                GenerationsPlayerTrack(
                  audioDuration: audioDuration,
                  currentDuration: currentDuration,
                  onChange: (value) {
                    double newPositionInMs =
                        (value * audioDuration.inMilliseconds) / 100;
                    currentDuration = Duration(
                      milliseconds: newPositionInMs.round(),
                    );
                    player.seek(currentDuration);
                    setState(() {});
                  },
                ),
              ],
            ).gap(24),
            GenerationsAudioPrompt(widget.audioInstance.request.text),
          ],
        ).gap(16),
      ),
    );
  }
}

class GenerationsPlayerSource extends StreamAudioSource {
  final List<int> bytes;

  GenerationsPlayerSource({required this.bytes});

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
