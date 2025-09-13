import {
  Body,
  Controller,
  Get,
  HttpCode,
  Post,
  UseGuards,
} from '@nestjs/common';
import { TTSGenerationService } from 'src/services/generation/tts.service';
import { type TTSBody } from 'src/types/request';
import { MiddlewareAuthGuard } from 'src/middleware/auth.guard';
import { SkipAuth } from 'src/decorations/skip-auth';
import { HttpExceptionHandler } from 'src/utils/response';

@Controller('v1/generation')
export class GenerationController {
  constructor(private readonly ttsGenerationService: TTSGenerationService) {}

  /// This entry point will be ignored the middleware authorization check.
  @SkipAuth()
  @Get('/health')
  whoAmI(): string {
    return 'Sympho - AI Speech Generation Service';
  }

  @UseGuards(MiddlewareAuthGuard)
  @HttpCode(200)
  @Post('/tts')
  async generateTTS(@Body() body: TTSBody) {
    const result = await this.ttsGenerationService.runner(body);

    if (result.error != null || result.audio == null) {
      return HttpExceptionHandler(result.error ?? 'internal-error');
    }

    return result;
  }
}
