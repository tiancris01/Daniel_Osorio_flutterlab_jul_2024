import 'package:prueba_tecnica_2024/src/data/data/models/document_model.dart';

abstract class DocumentsRemoteDataSource {
  Future<List<DocumentModel>> fetchDocuments();
}
