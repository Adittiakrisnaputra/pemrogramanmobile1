import 'package:flutter/material.dart';
import 'package:pemrogramanmobile1/detailpage.dart';

class Dosen {
  final String nama;
  final String gelar;
  final String fotoUrl;
  final String pendidikanS1;
  final String pendidikanS2;
  final String mataKuliahUtama;
  final List<String> semuaMataKuliah;

  const Dosen({
    required this.nama,
    required this.gelar,
    required this.fotoUrl,
    required this.pendidikanS1,
    required this.pendidikanS2,
    required this.mataKuliahUtama,
    required this.semuaMataKuliah,
  });
}

final List<Dosen> daftarDosen = [
  const Dosen(
    nama: "Dr. Budi Santoso",
    gelar: "M.Kom.",
    fotoUrl: "", // Dikosongkan karena menggunakan ikon
    pendidikanS1: "S.T. - Teknik Informatika, UGM",
    pendidikanS2: "M.Kom. - Ilmu Komputer, ITB",
    mataKuliahUtama: "Pemrograman Mobile",
    semuaMataKuliah: ["Pemrograman Mobile", "Kecerdasan Buatan", "Struktur Data"],
  ),
  const Dosen(
    nama: "Dr. Rina Wulandari",
    gelar: "M.T.",
    fotoUrl: "",
    pendidikanS1: "S.Kom. - Sistem Informasi, UI",
    pendidikanS2: "M.T. - Rekayasa Perangkat Lunak, ITS",
    mataKuliahUtama: "Basis Data",
    semuaMataKuliah: ["Basis Data Lanjut", "Data Mining", "Manajemen Proyek TI"],
  ),
  const Dosen(
    nama: "Prof. Dr. Agus Hartono",
    gelar: "M.Sc.",
    fotoUrl: "",
    pendidikanS1: "S.Si. - Matematika, IPB",
    pendidikanS2: "M.Sc. - Computer Science, NUS",
    mataKuliahUtama: "Jaringan Komputer",
    semuaMataKuliah: ["Jaringan Komputer", "Keamanan Informasi", "Sistem Terdistribusi"],
  ),
  const Dosen(
    nama: "Dr. Siti Aminah",
    gelar: "Ph.D.",
    fotoUrl: "",
    pendidikanS1: "S.T. - Teknik Elektro, Undip",
    pendidikanS2: "Ph.D. - Electrical Engineering, NTU",
    mataKuliahUtama: "Interaksi Manusia & Komputer",
    semuaMataKuliah: ["Interaksi Manusia & Komputer", "Desain UI/UX", "Grafika Komputer"],
  ),
  const Dosen(
    nama: "Dr. Iwan Setiawan",
    gelar: "M.Cs.",
    fotoUrl: "",
    pendidikanS1: "S.Kom. - Ilmu Komputer, Unpad",
    pendidikanS2: "M.Cs. - Computer Science, UGM",
    mataKuliahUtama: "Analisis Algoritma",
    semuaMataKuliah: ["Analisis Algoritma", "Teori Bahasa & Automata", "Kriptografi"],
  ),
  const Dosen(
    nama: "Dr. Dewi Lestari",
    gelar: "S.Pd., M.Pd.",
    fotoUrl: "",
    pendidikanS1: "S.Pd. - Pendidikan TIK, UPI",
    pendidikanS2: "M.Pd. - Teknologi Pendidikan, UNY",
    mataKuliahUtama: "Metodologi Penelitian",
    semuaMataKuliah: ["Metodologi Penelitian", "Statistika", "Etika Profesi"],
  ),
];

// --- TITIK AWAL APLIKASI UNTUK FILE INI ---
// Fungsi main() membuat file ini bisa dijalankan secara langsung.
void main() {
  runApp(const MyApp());
}

// Widget pembungkus utama yang berisi MaterialApp.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Dosen',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
        useMaterial3: true,
      ),
      home: const ProfilePage(), // Memulai dari halaman daftar dosen.
    );
  }
}

// --- HALAMAN UTAMA (DAFTAR DOSEN) ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Dosen Teknik Informatika"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // Menggunakan ListView.builder untuk membuat daftar yang bisa di-scroll.
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: daftarDosen.length, // Jumlah item sesuai panjang daftar dosen.
        itemBuilder: (context, index) {
          final dosen = daftarDosen[index];
          // Setiap item adalah Card yang bisa di-klik.
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell( // Membuat Card bisa di-klik.
              onTap: () {
                // Aksi saat di-klik: Buka halaman detail dan kirim data dosen yang dipilih.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(dosen: dosen),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // FOTO DIGANTI DENGAN IKON PROFIL
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Kolom untuk Nama, Pendidikan, dan Mata Kuliah
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${dosen.nama}, ${dosen.gelar}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          _buildMiniInfo(Icons.school_outlined, dosen.pendidikanS2),
                          const SizedBox(height: 3),
                          _buildMiniInfo(Icons.book_outlined, dosen.mataKuliahUtama),
                        ],
                      ),
                    ),
                    // Ikon panah ke kanan sebagai penanda bisa di-klik.
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMiniInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 14),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[800], fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
