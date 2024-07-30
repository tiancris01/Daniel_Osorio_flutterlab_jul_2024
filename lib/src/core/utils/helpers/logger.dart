import 'dart:io';

import 'package:flutter/foundation.dart';

class Logger {
  static final _regExp = RegExp(r'\n');
  // Fuccia
  static void message(String message) {
    final message0 = message.replaceAll(_regExp, ' ');
    if (kIsWeb || Platform.isAndroid) {
      debugPrint(
        '\x1b[35m[ VITAVI LOG ] $message0\x1b[0m',
      );
    } else {
      debugPrint(
        '[ VITAVI LOG ] $message',
      );
    }
  }

  // Rojo
  static void error(String message, {String? name}) {
    final message0 = message.replaceAll(_regExp, ' ');
    if (kIsWeb || Platform.isAndroid) {
      debugPrint(
        '\x1b[31m[ UDG LOG ERROR ${name != null ? '($name)' : ''} ] $message0\x1b[0m',
      );
    } else {
      debugPrint(
        '[ UDG LOG ERROR ${name != null ? '($name)' : ''} ] $message0',
      );
    }
  }

  // Amarillo
  static void warning(String message) {
    final message0 = message.replaceAll(_regExp, ' ');
    if (kIsWeb || Platform.isAndroid) {
      debugPrint(
        '\x1b[33m[ UDG LOG WARNING ] $message0\x1b[0m',
      );
    } else {
      debugPrint(
        '[ UDG LOG WARNING ] $message0',
      );
    }
  }

  // Cyan
  static void info(String message, {String? name}) {
    final message0 = message.replaceAll(_regExp, ' ');
    if (kIsWeb || Platform.isAndroid) {
      debugPrint(
          '\x1b[36m[ UDG LOG INFO ${name != null ? '($name)' : ''} ] $message0\x1b[0m');
    } else {
      debugPrint(
        '[ UDG LOG INFO ${name != null ? '($name)' : ''} ] $message0',
      );
    }
  }

  // Verde
  static void debug(String message) {
    final message0 = message.replaceAll(_regExp, ' ');
    if (kIsWeb || Platform.isAndroid) {
      debugPrint(
        '\x1b[32m[ UDG LOG DEBUG ] $message0\x1b[0m',
      );
    } else {
      debugPrint(
        '[ UDG LOG DEBUG ] $message0',
      );
    }
  }

  // Log para PROD con color VIOLETA
  static void release(String message) {
    final message0 = message.replaceAll(_regExp, ' ');
    if (kIsWeb || Platform.isAndroid) {
      debugPrint(
        '\x1b[35m[ UDG LOG PROD ] $message0\x1b[0m',
      );
    } else {
      debugPrint(
        '[ UDG LOG PROD ] $message0',
      );
    }
  }
}
