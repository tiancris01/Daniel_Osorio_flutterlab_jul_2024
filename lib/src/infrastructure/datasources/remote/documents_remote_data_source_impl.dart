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
  Future<List<DocumentModel>> fetchDocuments(int limit,
      {String? nameLast}) async {
    try {
      Query query =
          _firestore.collection('slowData').orderBy('name').limit(limit);
      if (nameLast != null) {
        query = query.startAfter([nameLast]);
      }
      // final Stopwatch stopwatch = Stopwatch()..start();
      final response = await query.get() as QuerySnapshot<Map<String, dynamic>>;
      // print('Query time: ${stopwatch.elapsedMilliseconds}');
      // stopwatch.stop();
      await Future.delayed(const Duration(seconds: 2));
      final jsonData = _addIdJson(response);
      return jsonData.map((e) => DocumentModel.fromJson(e)).toList();
    } on Error catch (e) {
      throw GeneralFailure(e.toString());
    } on Exception catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  /// Este método se encarga de agregar el id al json de los documentos obtenidos de Firestore.
  List<Map<String, dynamic>> _addIdJson(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.docs.map((document) {
      final data = document.data();
      data['name'] = data['name'] ?? 'No name';
      data['id'] = document.id;
      return data;
    }).toList();
    return json;
  }
}
