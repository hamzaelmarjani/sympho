import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../data/theme/shadcn.dart';

class PromptSettingsInfo extends StatelessWidget {
  final String info;
  final IconData icon;

  const PromptSettingsInfo(this.info, {super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
          context: context,
          alignment: Alignment.bottomCenter,
          builder: (context) {
            return ModalContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: ShadcnThemer().secondary(),
                  ),
                  Text(
                    info,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.gray.shade400,
                    ),
                  ),
                ],
              ).gap(12),
            );
          },
        ).future;
      },
      icon: Icon(LucideIcons.info, color: Colors.gray.shade400),
      variance: ButtonStyle.ghost(),
      size: ButtonSize.small,
    );
  }
}
