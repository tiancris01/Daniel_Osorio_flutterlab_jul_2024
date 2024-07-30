import 'package:flutter/services.dart';
import 'package:prueba_tecnica_2024/src/core/error_handling/failure.dart';
import 'package:prueba_tecnica_2024/src/core/utils/helpers/logger.dart';

class ExceptionFailure extends Failure {
  final Exception? error;
  @override
  final String? message;
  ExceptionFailure._({
    this.error,
    this.message,
  });
  factory ExceptionFailure.decode(Exception? error) {
    Logger.error(error.toString(), name: 'FAILURE[EXCEPTION]');
    return ExceptionFailure._(
      error: error,
      message: error.toString(),
    );
  }
}

class PlatformFailure extends Failure {
  @override
  final String? message;
  final PlatformException? error;

  PlatformFailure._({
    this.message,
    this.error,
  });

  factory PlatformFailure.decode(PlatformException? error) {
    Logger.error((error).toString(), name: 'FAILURE[PLATFORM][ERROR]');
    Logger.error((error?.message).toString(),
        name: 'Failure[PLATFORM][MESSAGE]');
    Logger.error((error?.stacktrace).toString(),
        name: 'Failure[PLATFORM][TRACE]');
    return PlatformFailure._(
      error: error,
      message: error?.message,
    );
  }
}

class FirebaseAuthFailure extends Failure {
  final Exception? error;
  @override
  final String? message;
  FirebaseAuthFailure._({this.error, this.message});
  factory FirebaseAuthFailure.decode(Exception? error, String message) {
    Logger.error(error.toString(), name: 'FAILURE[EXCEPTION]');
    switch (message) {
      case 'invalid-verification-code':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Código de verificación inválido',
        );
      case 'invalid-verification-code':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Código de verificación inválido, intenta nuevamente',
        );
      case 'invalid-credential':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Credenciales inválidas, sms code incorrecto',
        );
      case 'invalid-verification-id':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Código de verificación inválido',
        );
      case 'too-many-requests':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Demasiados intentos, intenta más tarde',
        );
      case 'session-expired':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Sesión expirada, intenta nuevamente',
        );
      case 'invalid-phone-number':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Número de teléfono inválido',
        );
      case 'user-disabled':
        return FirebaseAuthFailure._(
          error: error,
          message: 'Usuario deshabilitado',
        );
      case 'phone-number-already-exists':
        return FirebaseAuthFailure._(
          error: error,
          message: 'El número de teléfono ya está en uso',
        );
      default:
        return FirebaseAuthFailure._(
          error: error,
          message: 'Ha ocurrido un error, por favor intenta de nuevo.',
        );
    }
  }
}
