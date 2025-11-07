
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Pengembang"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Card(
          elevation: 8.0,
          margin: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Agar ukuran card mengikuti konten
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "BIODATA",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/0/0d/Logo_UIN_STS_Jambi.jpg"),
                  backgroundColor: Colors.black12,
                ),

                const SizedBox(height: 20),

                // -- Widget helper untuk merapikan kode --
                _buildInfoRow(
                  icon: Icons.person,
                  text: "Nama: Adittia Krisna Putra",
                  iconColor: Colors.blueAccent,
                ),
                const SizedBox(height: 10),

                _buildInfoRow(
                  icon: Icons.wallet_travel,
                  text: "Prodi: Sistem Informasi",
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 10),

                _buildInfoRow(
                  icon: Icons.school,
                  text: "NIM: 701230037",
                  iconColor: Colors.orange,
                ),
                const SizedBox(height: 10),

                _buildInfoRow(
                  icon: Icons.videogame_asset,
                  text: "Hobi: Bermain Game online dan jalan-jalan",
                  iconColor: Colors.redAccent,
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    // Tombol ini berfungsi untuk kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text("Kembali"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat baris info (praktik yang baik)
  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
