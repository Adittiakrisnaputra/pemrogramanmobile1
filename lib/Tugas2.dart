// lib/Tugas2.dart
import 'package:flutter/material.dart';
// Impor file detail_page.dart yang akan menjadi halaman daftar dosen
import 'package:pemrogramanmobile1/detail_page.dart';

void main() {
  // Menjalankan aplikasi dari file ini
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Memulai aplikasi dari HomePage
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Utama"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://media-cgk2-1.cdn.whatsapp.net/v/t61.24694-24/427506387_1584457689015876_5495055577631186668_n.jpg?ccb=11-4&oh=01_Q5Aa2wFd1rvxH4CmC9bTvaFZdtN5CGQmwVJqDMf4PugQEvsVyA&oe=6901EE9C&_nc_sid=5e03e0&_nc_cat=100"),
              ),
              const SizedBox(height: 20),
              const Text(
                "Profile dosen 5A Sistem Informasi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: Colors.teal, // Warna tombol agar serasi
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailPage()),
                  );
                },
                child: const Text("Lihat Daftar Dosen", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
