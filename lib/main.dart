import 'package:flutter/material.dart';
import 'package:hikebite/utils/Theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'pages/page_manager.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HikeBite',
      theme: ThemeData(
        colorScheme: colorScheme,
        // TODO: figure out how I want to handle text styles
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: colorScheme.primary,
          ),
          displayLarge: TextStyle(
            color: colorScheme.primary,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        '/': (context) => PageManager(),
        '/details': (context) => const SizedBox.shrink(),
      },
    );
  }
}
