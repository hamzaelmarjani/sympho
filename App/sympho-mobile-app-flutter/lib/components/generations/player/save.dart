import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uuid/uuid.dart';

class GenerationsAudioSaveToFiles extends StatelessWidget {
  final Uint8List audioData;

  const GenerationsAudioSaveToFiles({super.key, required this.audioData});

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      size: ButtonSize.small,
      icon: Icon(LucideIcons.save),
      enableFeedback: false,
      onPressed: () async {
        showMessage(String text, bool success) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Icon(
                  success ? LucideIcons.circleCheck : LucideIcons.x,
                  color: success ? Colors.green.shade500 : Colors.red.shade500,
                  size: 40,
                ),
                content: Text(text),
                actions: [
                  OutlineButton(
                    child: const Text('Done'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }

        try {
          /// Random id as the file name, you can change it.
          /// Just make sure is unique, otherwise the plugin will overwrite it.
          final id = Uuid().v4();

          await FileSaver.instance.saveFile(
            bytes: audioData,
            name: "sympho-$id",
            mimeType: MimeType.mp3,
          );

          showMessage('Audio saved to Files successfully.', true);
        } catch (err) {
          showMessage(
            "Unable to save your Audio file, something went wrong.",
            false,
          );
        }
      },
    );
  }
}
