import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { TTSBody } from 'src/types/request';
import { TTSResponse } from 'src/types/response';
import { ElevenLabsClient } from '@elevenlabs/elevenlabs-js';
import { MODELS } from 'src/data/models';
import { extractUint8Array } from 'src/utils/audio';

@Injectable()
export class TTSGenerationService {
  constructor(private configService: ConfigService) {}

  async runner(body: TTSBody): Promise<TTSResponse> {
    let response: TTSResponse = {
      error: 'internal-error',
      audio: null,
    };

    const apiKey: string | undefined =
      this.configService.get<string>('ELEVENLABS_API_KEY');

    if (!apiKey) {
      return response;
    }

    try {
      const elevenlabs = new ElevenLabsClient({
        apiKey,
      });

      // TODO You may want to check if the user has access to this model
      // TODO then set false or true to lowMode.
      // TODO true = MODELS.ELEVEN_TURBO_V2_5, false = MODELS.ELEVEN_MULTILINGUAL_V1
      const lowMode = false;

      // TODO here we choose the model based on the low_mode parameter,
      // TODO you can set any model you want based on your situation.
      const model = lowMode
        ? MODELS.ELEVEN_MULTILINGUAL_V1
        : MODELS.ELEVEN_TURBO_V2_5;

      const audio = await elevenlabs.textToSpeech.convert(body.voice_id, {
        text: body.text,
        modelId: model,
        voiceSettings: {
          stability: body.voice_settings.stability,
          similarityBoost: body.voice_settings.similarity_boost,
          useSpeakerBoost: body.voice_settings.use_speaker_boost,
          style: body.voice_settings.style,
          speed: body.voice_settings.speed,
        },
      });

      const audioBits = await extractUint8Array(audio);

      if (audioBits != null) {
        response = {
          error: null,
          audio: audioBits,
        };
      } else {
        response.error = 'internal-error';
      }
    } catch (err) {
      console.error(err);
    }

    return response;
  }
}
