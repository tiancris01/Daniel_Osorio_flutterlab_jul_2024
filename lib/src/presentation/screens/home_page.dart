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
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error al obtener los datos: ${snapshot.error}'),
                );
              }
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

          /* 
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          snapshot.error != null
              ? const Center(
                  child: Text('Error al obtener los datos'),
                )
              : const Center(
                  child: Text('Datos obtenidos correctamente'),
                );
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
         */
        },
      ),
    );
  }
}
