import { SetMetadata } from '@nestjs/common';

export const SKIP_AUTH = 'SkipAuth';
export const SkipAuth = () => SetMetadata(SKIP_AUTH, true);
