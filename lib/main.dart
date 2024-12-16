import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

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
    // Cancelar el Timer cuando el widget se destruye
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Launcher Lottery'),
        ),
        body: Center(
            child: FilledButton.icon(
          onPressed: () {
            init();
          },
          label: const Text("Open"),
          icon: const Icon(Icons.open_in_new),
        )),
      ),
    );
  }
}
