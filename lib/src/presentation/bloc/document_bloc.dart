import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/usecases/fetch_document_usecase.dart';

class DocumentBloc {
  final FetchDocumentUsecase _fetchDocumentUsecase;
  final _documentController =
      StreamController<List<DocumentEntity>>.broadcast();
  final List<DocumentEntity> _documents = [];
  String? _nameLast;
  bool _isFetching = false;

  bool get isFetching => _isFetching; // Expose fetching status

  DocumentBloc({
    required FetchDocumentUsecase fetchDocumentUsecase,
  }) : _fetchDocumentUsecase = fetchDocumentUsecase;

  void fetchDocument() async {
    if (_isFetching) return;
    _isFetching = true;
    final result = await _fetchDocumentUsecase(20, nameLast: _nameLast);
    result.fold(
      (failure) => _documentController.addError(failure),
      (documents) {
        if (documents.isNotEmpty) {
          _nameLast = documents.last.title;
          _documents.addAll(documents);
          _documentController.add(_documents); // Add the complete list
        }
        _isFetching = false;
      },
    );
  }

  void dispose() {
    _documentController.close();
  }

  Stream<List<DocumentEntity>> get documentStream => _documentController.stream;
}
