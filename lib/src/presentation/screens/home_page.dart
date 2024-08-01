import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/domain/entities/documents_entity.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_satate.dart';
import 'package:prueba_tecnica_2024/src/presentation/screens/widgets/custom_sliver_app_bar.dart';
import 'package:prueba_tecnica_2024/src/presentation/screens/widgets/custpm_sliver_list.dart';

/// HomePage es el widget principal de la aplicación, es el encargado de mostrar
/// la lista de documentos y de manejar el scroll para cargar más documentos
/// cuando se llega al final de la lista.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controlador del scroll para detectar cuando se llega al final de la lista
  final ScrollController _scrollController = ScrollController();

  /// Inicializa el controlador del scroll y agrega un listener para detectar
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  /// Listener que se ejecuta cuando se llega al final de la lista
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
      body: StreamBuilder<List<DocumentEntity>>(
        stream: state.documentStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data;
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          // CustomScrollView para mostrar la lista de documentos
          // y los Slivers necesarios para mostrar el CustomSliverAppBar
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              const CustomSliverAppBar(),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              CustomSliverList(documents: documents!)
            ],
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
