import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica_2024/src/core/errors/failures.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/repository/document_repository.dart';

/// La clase `FetchDocumentUsecase` se encarga de manejar la logica de negocio relacionada con la
/// obtención de los documentos almacenados en la base de datos.
class FetchDocumentUsecase {
  /// Repositorio que maneja la logica de negocio relacionada con la obtención de los documentos
  final DocumentRepository _documentRepository;

  /// Constructor de la clase `FetchDocumentUsecase`
  FetchDocumentUsecase({required DocumentRepository documentRepository})
      : _documentRepository = documentRepository;

  /// Este método se encarga de obtener los documentos almacenados en la base de datos.
  Future<Either<Failure, List<DocumentEntity>>> call() async {
    return await _documentRepository.fetchDocument();
  }
}
