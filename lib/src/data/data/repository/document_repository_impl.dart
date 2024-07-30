import 'package:dartz/dartz.dart';

import 'package:prueba_tecnica_2024/src/core/error_handling/failure.dart';
import 'package:prueba_tecnica_2024/src/data/data/datasources/remote/documents_remote_data_source.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/repository/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentsRemoteDataSource _documentsRemoteDataSource;
  DocumentRepositoryImpl({
    required DocumentsRemoteDataSource documentsRemoteDataSource,
  }) : _documentsRemoteDataSource = documentsRemoteDataSource;

  @override
  Future<Either<Failure, List<DocumentEntity>>> fetchDocument() async {
    try {
      final response = await _documentsRemoteDataSource.fetchDocuments();
      final documents =
          response.map((document) => document.toDomain()).toList();
      return Right(documents);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
