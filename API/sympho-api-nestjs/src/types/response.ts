import { HttpException } from '@nestjs/common';

export interface Responder<T> {
  exception?: HttpException;
  data: T;
}

export interface TTSResponse {
  error: string | null;
  audio: number[] | null;
}
