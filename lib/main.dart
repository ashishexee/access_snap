import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Opens YouTube
  void openYouTube() {
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.google.android.youtube',
    );
    intent.launch();
  }

  // Calls native method to start accessibility service
  Future<void> startAccessibility() async {
    const platform = MethodChannel('access_snap/channel');
    try {
      await platform.invokeMethod('openAccessibilitySettings');
    } on PlatformException catch (e) {
      debugPrint("Error: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Access Snap")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: openYouTube,
                child: const Text("Open YouTube"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: startAccessibility,
                child: const Text("Enable Accessibility"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
