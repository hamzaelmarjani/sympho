import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import helmet from 'helmet';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Enable helmet, read more: https://docs.nestjs.com/security/helmet
  app.use(helmet());

  // Enable CORS, read more: https://docs.nestjs.com/security/cors
  app.enableCors();

  await app.listen(process.env.PORT ?? 8080);
  console.log(`Application is running on: ${await app.getUrl()}`);
}
bootstrap();
