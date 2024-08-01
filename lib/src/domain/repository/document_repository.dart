import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica_2024/src/core/errors/failures.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';

/// La interfaz `DocumentReposito` defined el contrato para el repositorio que maneja la
/// logica relacionada con la decarga de los datos almacenados en el documento correspondiente
/// en la base de datos de Firebase.
/// La respuesta puede ser un `Failure` o una lista de `DocumentEntity`.
///
/// Tiene un solo método:
/// - `fetchDocument`: Este método se encarga de obtener los documentos almacenados en la base de datos.
///
abstract class DocumentRepository {
  /// Este método se encarga de obtener los datos almacenados en la base de datos.
  ///
  Future<Either<Failure, List<DocumentEntity>>> fetchDocument(int limit,
      {String? nameLast});
}
