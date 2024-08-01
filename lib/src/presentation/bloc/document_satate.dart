import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';

class DocumentState extends InheritedWidget {
  final DocumentBloc _data;

  const DocumentState.DocumentState({
    super.key,
    required super.child,
    required DocumentBloc data,
  }) : _data = data;

  static DocumentBloc of(BuildContext context) {
    final DocumentState? result =
        context.dependOnInheritedWidgetOfExactType<DocumentState>();
    if (result == null) {
      throw FlutterError(
          'DocumentState.of() called with a context that does not contain a DocumentState.');
    }
    return result._data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
