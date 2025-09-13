import { Module } from '@nestjs/common';
import { GenerationModule } from './modules/generation.module';
import { ConfigModule } from '@nestjs/config';
import { APP_GUARD } from '@nestjs/core';
import { MiddlewareAuthGuard } from './middleware/auth.guard';

@Module({
  imports: [
    ConfigModule.forRoot({
      ignoreEnvFile: true,
      isGlobal: true,
    }),
    GenerationModule,
  ],
  controllers: [],
  providers: [
    /// Apply the Middleware Auth Guard on all entry points
    /// except those with the @SkipAuth decorator
    {
      provide: APP_GUARD,
      useClass: MiddlewareAuthGuard,
    },
  ],
})
export class AppModule {}
