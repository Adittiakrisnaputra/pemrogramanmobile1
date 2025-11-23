import 'package:flutter/material.dart';
import 'screens/shopping_list_screen.dart'; // Path relatif yang benar

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: Colors.green, foregroundColor: Colors.white),
      ),
      home: const ShoppingListScreen(),
    );
  }
}
