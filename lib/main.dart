import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:hikebite/utils/Theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'pages/page_manager.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
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
