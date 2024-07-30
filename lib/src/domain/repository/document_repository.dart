import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica_2024/src/core/error_handling/failure.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';

abstract class DocumentRepository {
  Future<Either<Failure, List<DocumentEntity>>> fetchDocument();
}
