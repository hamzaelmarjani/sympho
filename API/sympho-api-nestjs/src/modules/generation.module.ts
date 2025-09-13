import { Module } from '@nestjs/common';
import { GenerationController } from 'src/controllers/generation.controller';
import { TTSGenerationService } from 'src/services/generation/tts.service';

@Module({
  imports: [],
  controllers: [GenerationController],
  providers: [TTSGenerationService],
})
export class GenerationModule {}
