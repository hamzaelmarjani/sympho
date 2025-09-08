import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    final opened = await launchUrl(uri);
    return opened;
  } catch (e) {
    return false;
  }
}
