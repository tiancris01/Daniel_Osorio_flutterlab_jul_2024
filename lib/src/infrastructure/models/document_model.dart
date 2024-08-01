import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

/// La clase `DocumentModel` o DTO es una clase de datos que representa el modelo de datos de un documento
///
@freezed
class DocumentModel with _$DocumentModel {
  const DocumentModel._();

  /// Constructor de la clase `DocumentModel`
  ///
  /// Recibe los siguientes parámetros:
  /// - `id`: Identificador del documento.
  /// - `name`: Nombre del documento.
  const factory DocumentModel({
    required String id,
    required String name,
  }) = _DocumentModel;

  /// Método que se encarga de serializar un objeto de tipo `Map<String, dynamic>` a un objeto de tipo `DocumentModel`
  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  /// Método que se encarga de transformar un objeto de tipo `DocumentModel` a un objeto de tipo `DocumentEntity`
  factory DocumentModel.fromDomain(DocumentEntity document) {
    return DocumentModel(
      id: document.id,
      name: document.title,
    );
  }

  /// Método que se encarga de serializar un objeto de tipo `DocumentEntity ` a un objeto de tipo `DocumentModel`
  DocumentEntity toDomain() {
    return DocumentEntity(
      id: id,
      title: name,
    );
  }
}
