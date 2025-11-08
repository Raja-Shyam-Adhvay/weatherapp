import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart'; // Start with LoadingScreen

void main() {
  runApp(const Clima());
}

class Clima extends StatelessWidget {
  const Clima({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // A dark theme suits the weather app!
      home: const LoadingScreen(), // Our starting screen
    );
  }
}
