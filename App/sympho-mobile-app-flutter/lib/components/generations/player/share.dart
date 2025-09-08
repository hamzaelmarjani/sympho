import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class GenerationsAudioShare extends StatefulWidget {
  final Uint8List audioData;

  const GenerationsAudioShare({super.key, required this.audioData});

  @override
  State<GenerationsAudioShare> createState() => _GenerationsAudioShareState();
}

class _GenerationsAudioShareState extends State<GenerationsAudioShare> {
  bool onProcess = false;

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      size: ButtonSize.small,
      enabled: !onProcess,
      icon: onProcess
          ? CircularProgressIndicator(size: 18)
          : Icon(LucideIcons.share2),
      enableFeedback: false,
      onPressed: () async {
        setState(() => onProcess = true);
        await Future.delayed(Duration(seconds: 1));

        try {
          final tempId = Uuid().v4();
          final tempDir = await getTemporaryDirectory();
          final tempFilePath = p.join(tempDir.path, "$tempId.mp3");
          final tempFile = File(tempFilePath);

          await tempFile.writeAsBytes(widget.audioData);

          SharePlus.instance.share(
            ShareParams(
              text: "Generated audio by Sympho",
              files: [XFile(tempFile.path)],
            ),
          );
        } catch (_) {}
        setState(() => onProcess = false);
      },
    );
  }
}
