import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sympho/classes/tts.dart';
import 'package:sympho/server/utils.dart';

import '../data/urls/server.dart';

class ServerCrud {
  static Dio dio = Dio();

  ServerCrud() {
    /// Dio plugins for seamless requests.
    /// It's safe to delete them.
    /// Make sure to do not delete Dio initialization above.
    dio.interceptors.addAll([
      /// Retry request if failed.
      /// Default to 3 retries, 1 sec delay between them.
      RetryInterceptor(
        dio: dio,
        logPrint: debugPrint,
        retries: 3,
        retryDelays: [1, 1, 1].map((s) => Duration(seconds: s)).toList(),
      ),

      /// Pretty the log of each request on the console
      /// Active only on DebugMode.
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    ]);
  }

  /// Send a TTS request to the server, requires `TTSRequest`
  /// Which includes what the server needs to convert Text-to-Speech.
  static Future<TTSResponse> requestTTS({required TTSRequest request}) async {
    TTSResponse response = TTSResponse();

    /// TODO Get the user stored refresh token.
    /// TODO We will use this refresh token for development propose only
    /// TODO In real application use the valid token.
    String? token = "f77cc4dd-b796-42e7-9c93-c7a69a83ec34";

    if (token == "") {
      response = TTSResponse(error: "unauthorized-request");
      return response;
    }

    try {
      /// We need to quantize Stability value
      /// Because EleveLabs accepts only one of those values: 0.0 | 0.5 | 1.0
      final stability = request.voiceSettings.stability;
      final double quantizedStability = stability < 0.25
          ? 0.0
          : (stability < 0.75 ? 0.5 : 1.0);

      Map<String, dynamic> voiceSettings = {
        "stability": quantizedStability,
        "similarity_boost": request.voiceSettings.similarityBoost,
        "style": request.voiceSettings.style,
        "use_speaker_boost": request.voiceSettings.useSpeakerBoost,
        "speed": request.voiceSettings.speed,
      };

      Map<String, dynamic> body = {
        "text": request.text,
        "voice_id": request.voiceId,
        "voice_settings": voiceSettings,
      };
      body.addEntries(body.entries);

      final result = await dio.post(
        ServerEntryPoints.generateTTS,
        data: body,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (result.statusCode.isSuccess()) {
        final data = result.data as Map<String, dynamic>;

        // TODO Handle the response depending on your server response
        // TODO We will use what Sympho server returns as `TTSResponse`

        if (data.containsKey("audio") && data["audio"] is List) {
          response = TTSResponse(audio: audioToUin8List(data["audio"]));
        } else {
          response = TTSResponse(
            error: data["error"] as String? ?? "internal-error",
          );
        }
      } else {
        response = TTSResponse(error: result.statusMessage ?? "internal-error");
      }
    } catch (err) {
      debugPrint(err.toString());
      response = TTSResponse(error: "unknown-error");
    }

    return response;
  }

  static Uint8List audioToUin8List(List<dynamic> audio) {
    List<int> intList = audio.cast<int>().toList();
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }
}
