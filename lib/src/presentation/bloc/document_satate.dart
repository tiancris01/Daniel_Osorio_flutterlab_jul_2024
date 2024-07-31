import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';

class DocumentSatate extends InheritedWidget {
  final DocumentBloc _data;

  const DocumentSatate({
    super.key,
    required super.child,
    required DocumentBloc data,
  }) : _data = data;

  static DocumentBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DocumentSatate>()!._data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
