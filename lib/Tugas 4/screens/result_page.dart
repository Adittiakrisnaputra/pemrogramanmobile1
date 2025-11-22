import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  // 1. Siapkan variabel untuk menampung KEDUA data
  final String nama;
  final String hobi;

  // 2. Buat constructor yang WAJIB menerima KEDUA data
  const ResultPage({
    super.key,
    required this.nama,
    required this.hobi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Biodata'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 3. Tampilkan data 'nama' yang diterima
              Text(
                'Halo, ${nama.isEmpty ? 'Tamu' : nama}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // 4. Tampilkan data 'hobi' yang diterima
              Text(
                'Hobi kamu adalah ${hobi.isEmpty ? 'rahasia' : hobi}.',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
