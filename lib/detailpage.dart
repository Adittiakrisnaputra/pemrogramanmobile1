import 'package:flutter/material.dart';
// Impor file profile.dart untuk bisa mengenali class Dosen
import 'package:pemrogramanmobile1/profile.dart';

// (void main dan MyAppDetail bisa ada di sini atau tidak, tergantung kebutuhan Anda)
void main() {
  runApp(const MyAppDetail());
}

class MyAppDetail extends StatelessWidget {
  const MyAppDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detail Dosen',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
        useMaterial3: true,
      ),
      home: DetailPage(dosen: daftarDosen[0]),
    );
  }
}

// --- HALAMAN DETAIL ---
class DetailPage extends StatelessWidget {
  final Dosen dosen;

  const DetailPage({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dosen.nama),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // --- PERUBAHAN DI SINI ---
                CircleAvatar(
                  radius: 60,
                  // Menggunakan warna latar belakang dari tema
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  // Menampilkan ikon profil
                  child: Icon(
                    Icons.person_outline,
                    size: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // -------------------------
                const SizedBox(height: 15),
                Text(
                  "${dosen.nama}, ${dosen.gelar}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Dosen Teknik Informatika",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const Divider(height: 40),
                _buildInfoRow(
                  icon: Icons.school_outlined,
                  label: "Pendidikan S1",
                  value: dosen.pendidikanS1,
                ),
                _buildInfoRow(
                  icon: Icons.school,
                  label: "Pendidikan S2",
                  value: dosen.pendidikanS2,
                ),
                _buildInfoRow(
                  icon: Icons.book_outlined,
                  label: "Mata Kuliah",
                  value: dosen.semuaMataKuliah.join(', '),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat baris informasi yang rapi
  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent[700], size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
