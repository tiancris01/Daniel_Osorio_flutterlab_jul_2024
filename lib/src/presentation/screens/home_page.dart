import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/core/utils/dependency_injection.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late DocumentBloc _documentBloc;
  final _container = DependencyInjection();
  StreamSubscription<DocumentEntity>? _subscription;

  @override
  void initState() {
    super.initState();
    final useCase = _container.fetchDocumentUsecase;
    _documentBloc = DocumentBloc(fetchDocumentUsecase: useCase);
    _documentBloc.fetchDocument();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _documentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Slow App'),
      ),
      body: StreamBuilder<List<DocumentEntity>>(
        stream: _documentBloc.documentStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching documents'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final document = snapshot.data![index];
                return ListTile(
                  title: Text(document.id),
                  subtitle: Text(document.title),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
