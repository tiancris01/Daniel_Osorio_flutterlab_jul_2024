import 'package:prueba_tecnica_2024/src/infrastructure/models/document_model.dart';

/// Esta clase es la interfaz que define el contrato de los métodos que se pueden
/// realizar en la fuente de datos remota de documentos.
abstract class DocumentsRemoteDataSource {
  /// Método que obtiene los documentos desde la fuente de datos remota.
  Future<List<DocumentModel>> fetchDocuments();
}
