import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica_2024/src/core/error_handling/failure.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/repository/document_repository.dart';

class FetchDocumentUsecase {
  final DocumentRepository _documentRepository;

  FetchDocumentUsecase({required DocumentRepository documentRepository})
      : _documentRepository = documentRepository;

  Future<Either<Failure, List<DocumentEntity>>> call() async {
    return await _documentRepository.fetchDocument();
  }
}
