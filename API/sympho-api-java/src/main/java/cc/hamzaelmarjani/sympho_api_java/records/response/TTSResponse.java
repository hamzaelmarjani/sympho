package cc.hamzaelmarjani.sympho_api_java.records.response;

import java.util.List;
import java.util.Optional;

public record TTSResponse(Optional<String> error, Optional<List<Integer>> audio) {
}