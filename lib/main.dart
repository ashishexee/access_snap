import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Opens Instagram or the Play Store if it's not installed
  void openInstagram(BuildContext context) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.instagram.android',
    );

    // Check if an app can handle this intent
    if (await intent.canResolveActivity() ?? false) {
      await intent.launch();
    } else {
      debugPrint("Instagram not installed. Opening Play Store.");
      // Fallback to opening the Play Store page
      final playStoreIntent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        data: 'market://details?id=com.instagram.android',
      );
      try {
        await playStoreIntent.launch();
      } on PlatformException catch (e) {
        debugPrint("Could not launch Play Store: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open Instagram or Play Store."),
          ),
        );
      }
    }
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
                onPressed: () => openInstagram(context),
                child: const Text("Open Instagram"),
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
