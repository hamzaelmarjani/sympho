use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct TTSBody {
    pub text: String,
    pub voice_id: String,
    pub voice_settings: ClientVoiceSettings,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClientVoiceSettings {
    pub stability: f32,
    pub similarity_boost: f32,
    pub style: f32,
    pub use_speaker_boost: bool,
    pub speed: f32,
}
