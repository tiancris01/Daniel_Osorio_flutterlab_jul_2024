import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_tecnica_2024/src/infrastructure/datasources/remote/documents_remote_data_source.dart';
import 'package:prueba_tecnica_2024/src/infrastructure/datasources/remote/documents_remote_data_source_impl.dart';
import 'package:prueba_tecnica_2024/src/infrastructure/repository/document_repository_impl.dart';
import 'package:prueba_tecnica_2024/src/domain/repository/document_repository.dart';
import 'package:prueba_tecnica_2024/src/domain/usecases/fetch_document_usecase.dart';

class DependencyInjection {
  static final DependencyInjection _singleton = DependencyInjection._internal();

  factory DependencyInjection() {
    return _singleton;
  }

  DependencyInjection._internal();

  late FirebaseFirestore _firestore;
  late DocumentsRemoteDataSource _documentsRemoteDataSource;
  late DocumentRepository _documentRepositoryImpl;
  late FetchDocumentUsecase _fetchDocumentUsecase;

  void init() {
    _firestore = FirebaseFirestore.instance;
    _documentsRemoteDataSource =
        DocumentsRemoteDataSourceImpl(firestore: _firestore);
    _documentRepositoryImpl = DocumentRepositoryImpl(
        documentsRemoteDataSource: _documentsRemoteDataSource);
    _fetchDocumentUsecase =
        FetchDocumentUsecase(documentRepository: _documentRepositoryImpl);
  }

  FetchDocumentUsecase get fetchDocumentUsecase => _fetchDocumentUsecase;
}
