import 'package:flutter/material.dart';

import 'views/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        iconTheme: const IconThemeData(
          color: Colors.amber,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
