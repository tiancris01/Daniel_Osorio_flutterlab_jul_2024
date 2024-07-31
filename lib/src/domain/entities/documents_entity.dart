import 'package:freezed_annotation/freezed_annotation.dart';

part 'documents_entity.freezed.dart';

/// La clase `DocumentEntity` es una clase de datos que representa un documento almacenado
/// en una base de datos en firebase.
///
/// Tiene los siguientes atributos:
/// - `id`: Un `String` que representa el identificador del documento.
/// - `title`: Un `String` que representa el título del documento. This
@freezed
class DocumentEntity with _$DocumentEntity {
  /// Constructor de clase abstracta para crear una instancia de `DocumentEntity`.
  const DocumentEntity._();
  const factory DocumentEntity({
    /// Un `String` que representa el identificador del documento.
    required String id,

    /// Un `String` que representa el título del documento.
    required String title,
  }) = _DocumentEntity;
}
