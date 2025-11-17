import 'package:flutter/material.dart';
import 'package:animated_loaders/animated_loaders.dart';

void main() {
  runApp(const AnimatedLoadersDemoApp());
}

class AnimatedLoadersDemoApp extends StatelessWidget {
  const AnimatedLoadersDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Loaders Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const LoaderHomePage(),
    );
  }
}

class LoaderHomePage extends StatefulWidget {
  const LoaderHomePage({super.key});

  @override
  State<LoaderHomePage> createState() => _LoaderHomePageState();
}

class _LoaderHomePageState extends State<LoaderHomePage> {
  AnimatedLoaderType _type = AnimatedLoaderType.bouncingDots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Loaders'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select a Loader Style',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // Loader selection chips
          Wrap(
            spacing: 8,
            children: [
              _chip('Bouncing Dots', AnimatedLoaderType.bouncingDots),
              _chip('Wave Dots', AnimatedLoaderType.waveDots),
              _chip('Scaling Dots', AnimatedLoaderType.scalingDots),
              _chip('Fading Dots', AnimatedLoaderType.fadingDots),
            ],
          ),

          const SizedBox(height: 40),

          // Selected loader preview
          Center(
            child: AnimatedLoader(type: _type, size: 60, color: Colors.blue),
          ),

          const SizedBox(height: 24),

          const Text(
            'Smooth, user-friendly loading animations 😎',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// UI chip widget for changing loader type
  Widget _chip(String label, AnimatedLoaderType type) {
    final selected = _type == type;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() => _type = type);
      },
    );
  }
}
