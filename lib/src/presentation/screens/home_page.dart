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
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    DocumentBloc state = DocumentSatate.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Slow App'),
      ),
      body: StreamBuilder<List<DocumentEntity>>(
        stream: state.documentStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error al obtener los datos: ${snapshot.error}'),
                );
              }
              return ListView.builder(
                controller: scrollController,
                itemCount: state.isLoading
                    ? snapshot.data!.length + 1
                    : snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (index < snapshot.data!.length) {
                    return ListTile(
                      title: Text(snapshot.data![index].id),
                      subtitle: Text(snapshot.data![index].title),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
          }
        },
      ),
    );
  }

  void _scrollListener() {
    final state = DocumentSatate.of(context);
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent - 100) {
      if (!state.isLoading) {
        state.isLoading = true;
        state.fetchDocument();
        state.isLoading = false;
      }
    }
  }
}
