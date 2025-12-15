import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pemrogramanmobile1/UAS/providers/movie_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita panggil fetchCustomMovies untuk memastikan data selalu segar saat tab ini dibuka
    Provider.of<MovieProvider>(context, listen: false).fetchCustomMovies();

    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          // Kita gunakan getter 'favoriteMovies' yang sudah kita buat di provider
          final favoriteMovies = provider.favoriteMovies;

          // Jika tidak ada film favorit, tampilkan pesan ini
          if (favoriteMovies.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada film favorit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Tambahkan film dari Beranda',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Jika ada film favorit, tampilkan dalam bentuk daftar
          return ListView.builder(
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie.posterUrl,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.movie, size: 60),
                    ),
                  ),
                  title: Text(
                    movie.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${movie.director} (${movie.year})'),
                  // Tombol Hapus Film dari Halaman Favorit
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                    tooltip: 'Hapus dari daftar',
                    onPressed: () {
                      // Tampilkan dialog konfirmasi sebelum menghapus
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus "${movie.title}" dari daftar?'),
                          actions: [
                            TextButton(
                              child: const Text('Batal'),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Hapus'),
                              onPressed: () {
                                // Panggil fungsi deleteMovie dari provider
                                provider.deleteMovie(movie.id!);
                                Navigator.of(ctx).pop(); // Tutup dialog

                                // Tampilkan notifikasi
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('"${movie.title}" telah dihapus.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
