import 'package:flutter/material.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open the box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false; // Track the current theme state

  void toggleTheme(bool isDark) {
    setState(() {
      isDarkTheme = isDark; // Update the theme state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme
          ? ThemeData.dark()
          : ThemeData.light(), // Set the theme based on state
      home: HomePage(
        onThemeChange:
            toggleTheme, // Pass the theme change function to HomePage
      ),
    );
  }
}
