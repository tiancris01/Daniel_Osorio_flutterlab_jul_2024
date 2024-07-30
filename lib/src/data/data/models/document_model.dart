import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
class DocumentModel with _$DocumentModel {
  const DocumentModel._();
  const factory DocumentModel({
    required String id,
    required String name,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  factory DocumentModel.fromDomain(DocumentEntity document) {
    return DocumentModel(
      id: document.id,
      name: document.title,
    );
  }

  DocumentEntity toDomain() {
    return DocumentEntity(
      id: id,
      title: name,
    );
  }
}
