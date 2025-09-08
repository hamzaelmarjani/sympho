import 'package:flutter/foundation.dart';

String baseUrl() {
  String url =
       /// TODO: If you are running on Android, make sure to run this command
      /// TODO: with your API server port, from your terminal or command line.
     /// TODO: command: adb reverse tcp:8080 tcp:8080
    /// TODO: then add this port to to the url, example port here is: 8080
      kDebugMode
      ? "http://localhost:8080"
      /// TODO: If the environment Production add the API server url.
      : "https://api.example.com";

  return url;
}

class ServerEntryPoints {
  static String generateTTS = "${baseUrl()}/v1/generation/tts";
}
