import 'package:flutter/material.dart';
import 'package:prueba_tecnica_2024/src/core/utils/dependency_injection.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_bloc.dart';
import 'package:prueba_tecnica_2024/src/presentation/bloc/document_satate.dart';
import 'package:prueba_tecnica_2024/src/presentation/screens/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final di = DependencyInjection();
    final useCase = di.fetchDocumentUsecase;
    final documentBloc = DocumentBloc(fetchDocumentUsecase: useCase);
    documentBloc.fetchDocument();
    return DocumentState.DocumentState(
      data: documentBloc,
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
