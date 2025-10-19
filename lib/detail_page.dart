import 'package:flutter/material.dart';import 'package:pemrogramanmobile1/dosen_model.dart'; // Impor model Dosen

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Dosen> daftarDosen = [
    Dosen(
      nama: "AHMAD NASUKHA, S.Hum., M.S.I",
      fotoUrl: "https://media-cgk1-1.cdn.whatsapp.net/v/t61.24694-24/344445992_1920982241627639_5305099372989098602_n.jpg?ccb=11-4&oh=01_Q5Aa2wHV-35Xy3Uli0sw9SPt3gt1W-23wmqU6LeAU7nG79PBIw&oe=69020778&_nc_sid=5e03e0&_nc_cat=105",
      deskripsi: "Dosen Sistem Informasi",
      mataKuliah: ['Pemrograman Mobile'],
    ),
    Dosen(
      nama: "Wahyu Anggoro, M.Kom.",
      fotoUrl: "https://i.pravatar.cc/150?img=11",
      deskripsi: "Dosen Sistem Informasi",
      mataKuliah: ['Manajemen Resiko'],
    ),
    Dosen(
      nama: " M. Yusuf,",
      fotoUrl: "https://i.pravatar.cc/150?img=34",
      deskripsi: "Dosen Sistem Informasi",
      mataKuliah: ['Technopreneurship'],
    ),
    Dosen(
      nama: "Dila Nurlaila, M.Kom",
      fotoUrl: "https://i.pravatar.cc/150?img=12",
      deskripsi: "Dosen Sistem Informasi",
      mataKuliah: ['Rekayasa Perangkat Lunak'],
    ),
    Dosen(
      nama: "Fatima Felawati,",
      fotoUrl: "https://i.pravatar.cc/150?img=49",
      deskripsi: "Dosen Sistem Informasi",
      mataKuliah: ['Testing dan Implementasi Sistem'],
    ),
    Dosen(
      nama: " Pol Metra, M.Kom.",
      fotoUrl: "https://i.pravatar.cc/150?img=25",
      deskripsi: "Dosen Sistem Informasi",
      mataKuliah: ['Multimedia'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Dosen"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[200], // Warna latar belakang halaman
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: daftarDosen.length,
        itemBuilder: (context, index) {
          final dosen = daftarDosen[index];
          // Panggil widget DosenProfileCard untuk setiap dosen
          return DosenProfileCard(dosen: dosen);
        },
      ),
    );
  }
}

class DosenProfileCard extends StatelessWidget {
  final Dosen dosen;

  const DosenProfileCard({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris untuk Foto, Nama, dan Deskripsi
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(dosen.fotoUrl),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dosen.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dosen.deskripsi,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 25.0),

            // Judul bagian mata kuliah
            const Text(
              "Mata Kuliah Unggulan:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Daftar mata kuliah
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dosen.mataKuliah.map((mk) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      const Icon(Icons.school, color: Colors.teal, size: 20),
                      const SizedBox(width: 8),
                      Text(mk, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
