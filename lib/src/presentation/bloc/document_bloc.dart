import 'dart:async';

import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/repository/document_repository.dart';

class DocumentBloc {
  final DocumentRepository _documentRepository;

  DocumentBloc({required DocumentRepository documentRepository})
      : _documentRepository = documentRepository;

  Stream<List<DocumentEntity>> get documentState =>
      _documentStateController.stream;
  final _documentStateController = StreamController<List<DocumentEntity>>();

  void dispose() {
    _documentStateController.close();
  }

  void fetchDocuments() async {
    try {
      _documentStateController.add([]);
      final documents = await _documentRepository.fetchDocument();
      documents.fold(
        (l) => _documentStateController.addError(l),
        (r) => _documentStateController.add(r),
      );
    } catch (e) {
      _documentStateController.addError(e);
    }
  }
}
