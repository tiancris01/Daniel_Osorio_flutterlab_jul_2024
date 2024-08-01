import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_satate.dart';

/// CustomSliverList is a widget that shows a custom SliverList with a list of
/// documents.
class CustomSliverList extends StatelessWidget {
  const CustomSliverList({
    super.key,
    required this.documents,
  });

  final List<DocumentEntity> documents;

  @override
  Widget build(BuildContext context) {
    final state = DocumentState.of(context);
    return SliverList.builder(
      itemCount: documents.length + (state.isFetching ? 1 : 0),
      itemBuilder: (context, index) {
        final document = documents[index];
        if (index == documents.length - 1) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Card(
          child: ListTile(
            title: Text(document.title.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(document.id),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[900],
              child: Text('${index + 1}',
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}
