import 'package:flutter/material.dart';

import 'package:paralist/Giris_Sayfasi.dart';
import 'package:paralist/VeritabaniErisim.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VeritabaniErisim.veritabanierisim();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [],

      title: 'paralist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 39, 147, 255),
        ),
        useMaterial3: true,
      ),
      home: GirisSayfasi(),
    );
  }
}
