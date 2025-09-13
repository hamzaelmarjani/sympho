package cc.hamzaelmarjani.sympho_api_java.records.request.tts;

import cc.hamzaelmarjani.sympho_api_java.records.request.VoiceSettings;

public record TTSBody(String text, String voice_id, VoiceSettings voice_settings) {
}