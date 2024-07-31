import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/core/utils/dependency_injection.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_satate.dart';
import 'package:prueba_tecnica_2024/src/presentation/screens/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final useCase = DependencyInjection().fetchDocumentUsecase;
    return DocumentSatate(
      data: DocumentBloc(
        fetchDocumentUsecase: useCase,
      ),
      child: MaterialApp(
        title: 'Flutter Slow App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
