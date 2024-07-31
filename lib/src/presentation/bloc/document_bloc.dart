// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/usecases/fetch_document_usecase.dart';

class DocumentBloc {
  final FetchDocumentUsecase _fetchDocumentUsecase;
  final _documentController = StreamController<List<DocumentEntity>>();

  DocumentBloc({
    required FetchDocumentUsecase fetchDocumentUsecase,
  }) : _fetchDocumentUsecase = fetchDocumentUsecase;

  void fetchDocument() async {
    final result = await _fetchDocumentUsecase();
    result.fold(
      (failure) => _documentController.addError(failure),
      (documents) => _documentController.add(documents),
    );
  }

  void dispose() {
    _documentController.close();
  }

  Stream<List<DocumentEntity>> get documentStream => _documentController.stream;
}
