import 'package:prueba_tecnica_2024/src/core/error_handling/failure.dart';
import 'package:prueba_tecnica_2024/src/core/utils/helpers/logger.dart';

class ErrorFailure extends Failure {
  final Error? error;
  @override
  final String? message;
  ErrorFailure._({
    this.error,
    this.message,
  });
  factory ErrorFailure.decode(
    Error? error,
  ) {
    Logger.error(error.toString(), name: 'FAILURE[ERROR]');
    Logger.error((error?.stackTrace).toString(), name: 'FAILURE[ERROR][TRACE]');
    return ErrorFailure._(
      error: error,
      message: error.toString(),
    );
  }
}
