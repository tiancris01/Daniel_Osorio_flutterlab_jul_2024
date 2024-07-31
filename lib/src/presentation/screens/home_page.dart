import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_satate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DocumentBloc state = DocumentSatate.of(context);
    state.fetchDocument();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Slow App'),
      ),
      body: StreamBuilder<List<DocumentEntity>>(
        stream: state.documentStream,
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
