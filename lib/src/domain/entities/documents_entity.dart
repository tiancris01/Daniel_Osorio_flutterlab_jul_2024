import 'package:freezed_annotation/freezed_annotation.dart';

part 'documents_entity.freezed.dart';

@freezed
class DocumentEntity with _$DocumentEntity {
  const DocumentEntity._();
  const factory DocumentEntity({
    required String id,
    required String name,
  }) = _DocumentEntity;
}
