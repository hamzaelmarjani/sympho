use crate::structs::request::tts::TTSBody;
use elevenlabs_tts::{models, ElevenLabsTTSClient, ElevenLabsTTSError, VoiceSettings};
use std::env::var;

pub async fn make_tts(body: TTSBody, low_mode: bool) -> Result<Vec<u8>, ElevenLabsTTSError> {
    let api_key = var("ELEVENLABS_API_KEY");

    if api_key.is_err() {
        return Err(ElevenLabsTTSError::ApiError {
            status: 500,
            message: "internal-error".to_string(),
        });
    }

    let client = ElevenLabsTTSClient::new(api_key.unwrap());

    // TODO here we choose the model based on the low_mode parameter,
    // TODO you can set any model you want based on your situation.
    let model = if low_mode {
        models::elevanlabs_models::ELEVEN_MULTILINGUAL_V1
    } else {
        models::elevanlabs_models::ELEVEN_TURBO_V2_5
    };

    let voice_settings = VoiceSettings::default()
        .stability(body.voice_settings.stability)
        .similarity_boost(body.voice_settings.similarity_boost)
        .speaker_boost(body.voice_settings.use_speaker_boost)
        .style(body.voice_settings.style)
        .speed(body.voice_settings.speed);

    client
        .text_to_speech(body.text)
        .voice_id(body.voice_id)
        .voice_settings(voice_settings)
        .model(model)
        .execute()
        .await
}
