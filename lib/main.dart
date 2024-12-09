import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final ok = await LaunchApp.isAppInstalled(
      androidPackageName: 'com.diazcode.premiosrdd',
    );
    print(ok);
    if (ok) {
      await LaunchApp.openApp(
        androidPackageName: 'com.diazcode.premiosrdd',
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
          title: const Text('Launcher'),
        ),
        body: Center(
            child: FilledButton.tonal(
                onPressed: init, child: const Text("Abrir"))),
      ),
    );
  }
}
