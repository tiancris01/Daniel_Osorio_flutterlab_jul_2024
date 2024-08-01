import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_satate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final state = DocumentState.of(context);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!state.isFetching) {
        state.fetchDocument(); // Fetch more documents when reaching the end
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DocumentBloc state = DocumentState.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Slow App'),
      ),
      body: StreamBuilder<List<DocumentEntity>>(
        stream: state.documentStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!;
          return ListView.builder(
            controller: _scrollController,
            itemCount: documents.length + (state.isFetching ? 1 : 0),
            itemBuilder: (context, index) {
              final document = documents[index];
              if (index == documents.length - 1) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListTile(
                title: Text(document.title),
                subtitle: Text(document.id),
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
