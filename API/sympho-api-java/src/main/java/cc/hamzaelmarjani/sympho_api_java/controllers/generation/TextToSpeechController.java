package cc.hamzaelmarjani.sympho_api_java.controllers.generation;

import cc.hamzaelmarjani.sympho_api_java.records.request.tts.TTSBody;
import cc.hamzaelmarjani.sympho_api_java.records.response.TTSResponse;
import cc.hamzaelmarjani.sympho_api_java.services.generation.TextToSpeechGeneration;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/generation")
public class TextToSpeechController {
    private final TextToSpeechGeneration ttsService;

    public TextToSpeechController(TextToSpeechGeneration instance) {
        this.ttsService = instance;
    }

    @PostMapping("/tts")
    public ResponseEntity<TTSResponse> requestTTS(@RequestBody TTSBody body) {

        try {
            byte[] audioBytes = ttsService.makeTTS(body).block();

            if (audioBytes != null && audioBytes.length > 0) {
                List<Integer> audioList = new ArrayList<>();
                for (byte b : audioBytes) {
                    audioList.add(Byte.toUnsignedInt(b));
                }

                // Success → 200 OK
                return ResponseEntity.ok(new TTSResponse(Optional.empty(), Optional.of(audioList)));
            } else {
                // Bad request → 400
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(new TTSResponse(Optional.of("bad-request"), Optional.empty()));
            }
        } catch (Exception e) {
            System.err.println("Error during TTS API call: " + e.getMessage());
            // Internal server error → 500
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new TTSResponse(Optional.of("internal-error"), Optional.empty()));
        }
    }
}