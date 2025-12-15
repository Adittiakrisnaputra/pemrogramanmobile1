import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart'; // Pastikan path ini benar

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita tidak memerlukan AppBar di sini agar lebih menyatu dengan desain halaman lain
      body: ListView(
        // 'padding: EdgeInsets.zero' untuk menghilangkan spasi default di atas ListView
        padding: EdgeInsets.zero,
        children: [
          // Bagian Header dengan Logo Aplikasi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20), // Padding atas lebih besar untuk status bar
            // Gunakan warna dari tema saat ini agar dinamis
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              children: [
                // Pastikan logo sudah ada di 'assets/images/movielix_logo.png'
                Image.asset(
                  'assets/images/movielix_logo.png',
                  height: 80,
                  // Menambahkan error builder jika logo gagal dimuat
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.movie_creation_outlined, size: 80, color: Colors.grey);
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Movielix',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Versi 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Opsi untuk Mengubah Tema (Dark/Light Mode)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'TAMPILAN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          // Kita gunakan Consumer agar UI (ikon dan teks) bisa update otomatis
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: const Text('Mode Gelap'),
                subtitle: Text(themeProvider.isDarkMode ? 'Aktif' : 'Nonaktif'),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  // Panggil fungsi untuk mengubah tema dari provider
                  themeProvider.toggleTheme();
                },
                secondary: Icon(
                  themeProvider.isDarkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
              );
            },
          ),
          const Divider(indent: 16, endIndent: 16),

          // Opsi Lainnya
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'TENTANG APLIKASI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Dibuat untuk Proyek UAS'),
            onTap: () {
              // Di sini bisa ditambahkan dialog atau halaman baru
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Tentang Movielix'),
                  content: const Text(
                      'Aplikasi ini dibuat menggunakan Flutter sebagai bagian dari Ujian Akhir Semester.'),
                  actions: [
                    TextButton(
                      child: const Text('Tutup'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
