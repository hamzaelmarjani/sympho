import {
  BadGatewayException,
  BadRequestException,
  HttpException,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';

/**
 * Keep all exceptions in one place, good practice to always
 * make sure the client gets the same response
 * you can add all supposed exceptions here.
 *
 * @param message the message to handle
 */
export const HttpExceptionHandler = (message?: string): HttpException => {
  switch (message) {
    case 'unauthorized':
      return new UnauthorizedException(message);
    case 'bad-gateaway':
      return new BadGatewayException(message);
    case 'bad-gateaway':
      return new BadGatewayException(message);
    case 'bad-request':
      return new BadRequestException(message);
    default:
      return new InternalServerErrorException(message);
  }
};
