import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prueba_tecnica_2024/src/core/utils/dependency_injection.dart.dart';
import 'package:prueba_tecnica_2024/src/presentation/App.dart';

void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Run the app
  DependencyInjectionDart().init();
  runApp(const App());
}
