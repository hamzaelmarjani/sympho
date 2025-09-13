package cc.hamzaelmarjani.sympho_api_java.records.request.tts;

public record ElevenLabsVoiceSettings(
        double stability,
        double similarity_boost,
        double style,
        double speed,
        boolean use_speaker_boost) {
}
