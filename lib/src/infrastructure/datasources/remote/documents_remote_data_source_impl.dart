import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_tecnica_2024/src/core/errors/exceptions.dart';
import 'package:prueba_tecnica_2024/src/core/errors/failures.dart';

import 'package:prueba_tecnica_2024/src/infrastructure/datasources/remote/documents_remote_data_source.dart';
import 'package:prueba_tecnica_2024/src/infrastructure/models/document_model.dart';

/// La clase `DocumentsRemoteDataSourceImpl` es una clase que implementa la interfaz `DocumentsRemoteDataSource`.
/// En caso de ocurrir un error, regresa un `ServerFailure` o `ServerException` en caso de haber ocurrido una excepción.
/// Regresa una lista de `DocumentModel` en caso de obtener los datos satisfactoriamente.
class DocumentsRemoteDataSourceImpl implements DocumentsRemoteDataSource {
  /// - `_firestore`: Instancia de Firestore
  final FirebaseFirestore _firestore;
  DocumentsRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  /// Este método se encarga de obtener los documentos almacenados en la base de datos. se encarga
  /// de hacer una petición a la base de datos de Firestore y regresar una lista de `DocumentModel`.
  @override
  Future<List<DocumentModel>> fetchDocuments() async {
    try {
      final response = await _firestore.collection('documents').get();
      return response.docs
          .map((document) => DocumentModel.fromJson(document.data()))
          .toList();
    } on Error catch (e) {
      throw ServerFailure(e.toString());
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
