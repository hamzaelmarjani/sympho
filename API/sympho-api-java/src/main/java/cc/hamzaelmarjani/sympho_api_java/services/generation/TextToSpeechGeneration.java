package cc.hamzaelmarjani.sympho_api_java.services.generation;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import cc.hamzaelmarjani.sympho_api_java.data.ElevenlabsModels;
import cc.hamzaelmarjani.sympho_api_java.records.request.tts.ElevenLabsRequest;
import cc.hamzaelmarjani.sympho_api_java.records.request.tts.ElevenLabsVoiceSettings;
import cc.hamzaelmarjani.sympho_api_java.records.request.tts.TTSBody;
import reactor.core.publisher.Mono;

@Component
public class TextToSpeechGeneration {
    private final WebClient webClient;
    private final String elevenLabsApiKey;

    public TextToSpeechGeneration(@Value("${elevenlabs.api_key:${ELEVENLABS_API_KEY:NONE}}") String apiKey) {
        this.elevenLabsApiKey = apiKey;
        this.webClient = WebClient.builder()
                .baseUrl("https://api.elevenlabs.io/v1/text-to-speech/")
                .build();
    }

    public Mono<byte[]> makeTTS(TTSBody body) {
        String model;

        // TODO You may want to check if the user has access to this model
        // TODO then set false or true to lowMode.
        // TODO true = ElevenlabsModels.ELEVEN_TURBO_V2_5,
        // TODO false = ElevenlabsModels.ELEVEN_MULTILINGUAL_V1
        boolean lowMode = false;

        // TODO here we choose the model based on the lowMode parameter,
        // TODO you can set any model you want based on your situation.
        if (lowMode) {
            model = ElevenlabsModels.ELEVEN_MULTILINGUAL_V1;
        } else {
            model = ElevenlabsModels.ELEVEN_TURBO_V2_5;
        }

        ElevenLabsVoiceSettings voiceSettings = new ElevenLabsVoiceSettings(
                body.voice_settings().stability(),
                body.voice_settings().similarity_boost(),
                body.voice_settings().style(), body.voice_settings().speed(),
                body.voice_settings().use_speaker_boost());

        ElevenLabsRequest request = new ElevenLabsRequest(
                body.text(), model, voiceSettings);

        return webClient.post()
                .uri(body.voice_id() + "?output_format=mp3_44100_128")
                .body(Mono.just(request), ElevenLabsRequest.class)
                .header("xi-api-key", this.elevenLabsApiKey)
                .header("Content-Type", "application/json")
                .retrieve()
                .bodyToMono(byte[].class)
                .onErrorResume(e -> {
                    System.err.println("Error during TTS API call: " + e.getMessage());
                    return Mono.empty();
                });
    }
}
