import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Call the Toast widget from anywhere on the app
/// Configure the Toast options as you want below.
displayToast({
  required BuildContext context,
  required String subtitle,
  bool showClose = true,
  String? title,
  Widget? buttonChild,
  Duration showDuration = const Duration(seconds: 5),
}) {
  showToast(
    context: context,
    builder: (context, overlay) {
      return buildToast(overlay, subtitle, showClose, title, buttonChild);
    },
    location: ToastLocation.bottomCenter,
    showDuration: showDuration,
  );
}

Widget buildToast(
  ToastOverlay overlay,
  String subtitle,
  bool showClose,
  String? title,
  Widget? buttonChild,
) {
  return SurfaceCard(
    child: Basic(
      title: title != null ? Text(title) : null,
      subtitle: Text(subtitle),
      trailing: buttonChild != null || showClose
          ? PrimaryButton(
              size: ButtonSize.small,
              onPressed: () {
                overlay.close();
              },
              child: buttonChild ?? Icon(LucideIcons.x),
            )
          : null,
      trailingAlignment: Alignment.center,
    ),
  );
}
