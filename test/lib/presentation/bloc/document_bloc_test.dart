import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/domain/usecases/fetch_document_usecase.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';
import 'package:prueba_tecnica_2024/src/core/errors/failures.dart';

import 'document_bloc_test.mocks.dart';

@GenerateMocks([FetchDocumentUsecase])
void main() {
  late DocumentBloc documentBloc;
  late MockFetchDocumentUsecase mockFetchDocumentUsecase;

  setUp(() {
    mockFetchDocumentUsecase = MockFetchDocumentUsecase();
    documentBloc = DocumentBloc(fetchDocumentUsecase: mockFetchDocumentUsecase);
  });

  tearDown(() {
    documentBloc.dispose();
  });

  test('Deberia emitir una lista de documentos cuando se llame a fetchDocument',
      () async {
    final documents = [
      DocumentEntity(id: '1', title: 'Document 1'),
      DocumentEntity(id: '2', title: 'Document 2'),
    ];
    when(mockFetchDocumentUsecase(20, nameLast: null))
        .thenAnswer((_) async => Right(documents));

    documentBloc.fetchDocument();

    expect(
      documentBloc.documentStream,
      emitsInOrder([
        emits(documents),
      ]),
    );
  });

  test('should add error when fetchDocument fails', () async {
    final failure = ServerFailure('Server error');
    when(mockFetchDocumentUsecase(20, nameLast: null))
        .thenAnswer((_) async => Left(failure));

    documentBloc.fetchDocument();

    expect(
      documentBloc.documentStream,
      emitsInOrder([
        emitsError(failure),
      ]),
    );
  });

  test('should update _isFetching flag correctly', () async {
    final documents = [
      DocumentEntity(id: '1', title: 'Document 1'),
    ];
    when(mockFetchDocumentUsecase(20, nameLast: null))
        .thenAnswer((_) async => Right(documents));

    expect(documentBloc.isFetching, isFalse);
    documentBloc.fetchDocument();
    expect(documentBloc.isFetching, isTrue);

    await Future.delayed(Duration(milliseconds: 100));

    expect(documentBloc.isFetching, isFalse);
  });
}
