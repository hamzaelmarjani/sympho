import 'package:auto_size_text/auto_size_text.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/data/theme/shadcn.dart';

class GenerationsAudioPrompt extends StatelessWidget {
  final String text;

  const GenerationsAudioPrompt(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontFamily: ShadcnThemer().shadcnTheme.typography.sans.fontFamily,
        fontSize: 14,
        color: Colors.gray.shade400,
      ),
      textAlign: TextAlign.left,
      maxFontSize: 14,
      minFontSize: 14,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
