import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await init();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> init() async {
    final ok = await LaunchApp.isAppInstalled(
      androidPackageName: 'com.diazcode.lottery_screen',
    );
    if (ok) {
      await LaunchApp.openApp(
        androidPackageName: 'com.diazcode.lottery_screen',
        openStore: false,
      );
    }
  }

  Future<void> openSettings() async {
    const intent = AndroidIntent(
      action: 'android.settings.SETTINGS',
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Launcher'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Espaciado arriba
            ClipOval(
              child: Container(
                width: 250,
                height: 250,
                child: Image.asset(
                  'assets/icon.png', // Ruta de tu imagen en los assets
                  fit: BoxFit.cover, // Ajusta la imagen dentro del círculo
                ),
              ),
            ),
            const SizedBox(
                height: 30), // Espaciado entre la imagen y los botones
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      init();
                    },
                    label: const Text("Open App"),
                    icon: const Icon(Icons.open_in_new),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () {
                      openSettings();
                    },
                    label: const Text("Open Settings"),
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
