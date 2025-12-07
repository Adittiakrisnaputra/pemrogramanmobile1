import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart'; // -> Impor provider yang baru dibuat
import 'screens/home_screen.dart';     // -> Pastikan path ini benar

void main() {
  runApp(
    // 1. Bungkus aplikasi dengan ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Gunakan 'Consumer' untuk "mendengarkan" perubahan dari ThemeProvider
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'CRUD Catatan Mahasiswa',

          // 3. Definisikan tema untuk mode Terang (Light)
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            // Atur warna floating action button untuk light mode
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo,
            ),
          ),

          // 4. Definisikan tema untuk mode Gelap (Dark)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.teal, // Anda bisa ganti warnanya
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // Atur warna floating action button untuk dark mode
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.teal,
            ),
          ),

          // 5. Pilih mode tema berdasarkan status dari provider
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
