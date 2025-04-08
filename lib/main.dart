import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Projet Musique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFPro', // Utilise bien SF Pro depuis pubspec.yaml
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
