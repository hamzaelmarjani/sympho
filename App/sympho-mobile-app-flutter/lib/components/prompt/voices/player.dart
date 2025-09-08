import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/data/theme/shadcn.dart';

class PromptVoiceSamplePlay extends StatefulWidget {
  final String id;
  const PromptVoiceSamplePlay({super.key, required this.id});

  @override
  State<PromptVoiceSamplePlay> createState() => _PromptVoiceSamplePlayState();
}

class _PromptVoiceSamplePlayState extends State<PromptVoiceSamplePlay> {
  static AudioPlayer? _sharedPlayer;
  static String? _currentPlayingId;
  static final Set<_PromptVoiceSamplePlayState> _allInstances = {};

  bool isPlaying = false;
  bool isLoading = false;
  bool hasError = false;

  AudioPlayer get player {
    _sharedPlayer ??= AudioPlayer();
    return _sharedPlayer!;
  }

  @override
  void initState() {
    super.initState();
    _allInstances.add(this);
    player.playerStateStream.listen((state) {
      if (mounted) {
        _updateAllInstances();

        if (state.processingState == ProcessingState.completed &&
            _currentPlayingId == widget.id) {
          _stopCurrentAudio();
        }
      }
    });
  }

  @override
  void dispose() {
    _allInstances.remove(this);
    if (_allInstances.isEmpty) {
      _sharedPlayer?.dispose();
      _sharedPlayer = null;
      _currentPlayingId = null;
    }
    super.dispose();
  }

  static void _updateAllInstances() {
    for (var instance in _allInstances) {
      if (instance.mounted) {
        instance._updateState();
      }
    }
  }

  void _updateState() {
    setState(() {
      isPlaying = _currentPlayingId == widget.id && player.playing;
    });
  }

  Future<void> _playAudio() async {
    try {
      setState(() {
        hasError = false;
      });

      if (_currentPlayingId != widget.id) {
        setState(() {
          isLoading = true;
        });

        await player.stop();

        final asset = "assets/voices/samples/${widget.id}.mp3";
        await player.setAsset(asset);
        _currentPlayingId = widget.id;

        setState(() {
          isLoading = false;
        });
      }

      await player.play();
    } catch (err) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  static Future<void> _stopCurrentAudio() async {
    if (_sharedPlayer != null) {
      await _sharedPlayer!.seek(Duration.zero);
      await _sharedPlayer!.stop();
      _currentPlayingId = null;
      _updateAllInstances();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      enabled: !isLoading,
      variance: ButtonVariance.outline.withBorder(
        border: Border.all(
          color: isPlaying
              ? ShadcnThemer().secondary()
              : ShadcnThemer().border(),
        ),
      ),
      icon: isLoading
          ? const CupertinoActivityIndicator(radius: 9)
          : hasError
          ? const Icon(LucideIcons.info, size: 18, color: Colors.red)
          : Icon(
              isPlaying ? LucideIcons.pause : LucideIcons.play,
              size: 18,
              color: isPlaying ? ShadcnThemer().secondary() : null,
            ),
      onPressed: isLoading
          ? null
          : () async {
              if (_currentPlayingId == widget.id && player.playing) {
                await player.pause();
              } else {
                await _playAudio();
              }
            },
    );
  }
}
