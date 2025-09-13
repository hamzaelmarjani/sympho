export interface TTSBody {
  text: string;
  voice_id: string;
  voice_settings: ClientVoiceSettings;
}

export interface ClientVoiceSettings {
  stability: number;
  similarity_boost: number;
  style: number;
  use_speaker_boost: boolean;
  speed: number;
}
