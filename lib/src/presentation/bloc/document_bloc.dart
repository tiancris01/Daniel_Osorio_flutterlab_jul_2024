import 'dart:async';

import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/usecases/fetch_document_usecase.dart';

class DocumentBloc {
  final FetchDocumentUsecase _fetchDocumentUsecase;
  final _documentController = StreamController<List<DocumentEntity>>();
  bool isLoading = false;

  DocumentBloc({
    required FetchDocumentUsecase fetchDocumentUsecase,
  }) : _fetchDocumentUsecase = fetchDocumentUsecase;

  void fetchDocument({String? nameLast}) async {
    final result = await _fetchDocumentUsecase(20, nameLast: nameLast);
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
