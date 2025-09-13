package cc.hamzaelmarjani.sympho_api_java.records.request;

public record VoiceSettings(double stability, double similarity_boost, double style, boolean use_speaker_boost, double speed) {
}
