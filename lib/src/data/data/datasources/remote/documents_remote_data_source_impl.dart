import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_tecnica_2024/src/core/error_handling/error.dart';
import 'package:prueba_tecnica_2024/src/core/error_handling/exception.dart';

import 'package:prueba_tecnica_2024/src/data/data/datasources/remote/documents_remote_data_source.dart';
import 'package:prueba_tecnica_2024/src/data/data/models/document_model.dart';

class DocumentsRemoteDataSourceImpl implements DocumentsRemoteDataSource {
  final FirebaseFirestore _firestore;
  DocumentsRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<List<DocumentModel>> fetchDocuments() async {
    try {
      final response = await _firestore.collection('documents').get();
      return response.docs
          .map((document) => DocumentModel.fromJson(document.data()))
          .toList();
    } on Error catch (e) {
      throw ErrorFailure.decode(e);
    } on Exception catch (e) {
      throw ExceptionFailure.decode(e);
    }
  }
}
