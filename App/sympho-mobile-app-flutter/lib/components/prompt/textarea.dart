import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/data/audios.dart';
import 'package:sympho/provider/data/prompt.dart';

import '../../provider/ui/generate.dart';

class PromptTextArea extends StatelessWidget {
  const PromptTextArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneratedAudiosProvider>(
      builder: (context, generatedAudios, _) {
        return Consumer<PromptTextProvider>(
          builder: (context, text, _) {
            return Consumer<GenerateTTSProcessProvider>(
              builder: (context, process, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextArea(
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      enabled: !process.onProcess,
                      initialValue: text.text,
                      expandableHeight: false,
                      initialHeight: generatedAudios.audios.isNotEmpty
                          ? 180
                          : 250,
                      padding: EdgeInsets.all(8),
                      style: TextStyle(fontSize: 16),
                      maxLength: 4000,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      placeholder: Text(
                        "Start typing here or paste any text ...",
                        style: TextStyle(fontSize: 16),
                      ),
                      onChanged: (v) => text.set(v),
                    ),
                    Text(
                      "${text.text.length}/4000",
                      style: TextStyle(
                        color: Colors.gray.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ).gap(12);
              },
            );
          },
        );
      },
    );
  }
}
