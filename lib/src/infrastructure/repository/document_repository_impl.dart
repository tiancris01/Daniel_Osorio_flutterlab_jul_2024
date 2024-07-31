import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica_2024/src/core/errors/failures.dart';

import 'package:prueba_tecnica_2024/src/infrastructure/datasources/remote/documents_remote_data_source.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/repository/document_repository.dart';

/// La clase `DocumentRepositoryImpl` es una clase que implementa la interfaz `DocumentRepository`.
/// Regresa un Failure en caso de haber ocurrido un error o una lista de `DocumentEntity` en elcaso
/// de obtener los datos satisfactoriamente.
///
///
class DocumentRepositoryImpl implements DocumentRepository {
  /// - `DocumentsRemoteDataSource`: Fuente de datos remota de documentos
  final DocumentsRemoteDataSource _documentsRemoteDataSource;
  DocumentRepositoryImpl({
    required DocumentsRemoteDataSource documentsRemoteDataSource,
  }) : _documentsRemoteDataSource = documentsRemoteDataSource;

  /// Este método se encarga de obtener los documentos almacenados en la base de datos.
  /// EL metodo `toDomain` transforma el modelo a una entidad.
  @override
  Future<Either<Failure, List<DocumentEntity>>> fetchDocument() async {
    try {
      final response = await _documentsRemoteDataSource.fetchDocuments();
      // Transformar la lista de documentos de modelo a entidad
      final documents =
          response.map((document) => document.toDomain()).toList();
      return Right(documents);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
