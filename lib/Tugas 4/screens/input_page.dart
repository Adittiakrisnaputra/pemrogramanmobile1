// Lokasi: lib/Tugas 4/screens/input_page.dart

import 'package:flutter/material.dart';
import 'result_page.dart';

// ==========================================================
// HALAMAN UNTUK INPUT DAN MENGIRIM DATA
// ==========================================================
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hobiController = TextEditingController();

  void _sendDataToResultPage() {
    String nameToSend = _nameController.text;
    String hobiToSend = _hobiController.text;

    if (nameToSend.trim().isNotEmpty && hobiToSend.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          // ==========================================================
          // PERBAIKAN DI SINI: 'name' diubah menjadi 'nama'
          // ==========================================================
          builder: (context) => ResultPage(nama: nameToSend, hobi: hobiToSend),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan Hobi tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hobiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Input Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Nama',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hobiController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Hobi',
                prefixIcon: Icon(Icons.favorite),
              ),
              onSubmitted: (_) => _sendDataToResultPage(),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Kirim ke Halaman Hasil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _sendDataToResultPage,
            ),
          ],
        ),
      ),
    );
  }
}
