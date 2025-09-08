import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/components/generations/history.dart';

class UIAppBar extends StatelessWidget {
  const UIAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      borderWidth: 0,
      child: AppBar(
        title: Row(
          children: [
            Icon(LucideIcons.speech),
            const Text('Text To Speech', style: TextStyle(fontSize: 16)),
          ],
        ).gap(12).withMargin(left: 4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        trailingGap: 10,
        trailing: [GenerationsHistory()],
      ),
    );
  }
}
