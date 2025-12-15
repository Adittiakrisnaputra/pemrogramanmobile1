import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pemrogramanmobile1/UAS/providers/movie_provider.dart'; // Sesuaikan path jika perlu

class MyMoviesScreen extends StatelessWidget {
  const MyMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil fetchCustomMovies setiap kali halaman ini dibangun
    // Ini memastikan daftar selalu update
    Provider.of<MovieProvider>(context, listen: false).fetchCustomMovies();

    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.customMovies.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada film yang ditambahkan.\nSilakan tambah dari halaman Beranda.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.customMovies.length,
            itemBuilder: (context, index) {
              final movie = provider.customMovies[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    // GANTI posterPath menjadi posterUrl
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tombol Favorit
                      IconButton(
                        icon: Icon(
                          movie.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: movie.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          // Buat objek baru dengan status favorit yang dibalik
                          final updatedMovie = movie.copyWith(
                            isFavorite: !movie.isFavorite,
                          );
                          provider.updateMovie(updatedMovie);
                        },
                      ),
                      // Tombol Hapus
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          // Tampilkan dialog konfirmasi sebelum menghapus
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: Text(
                                  'Apakah Anda yakin ingin menghapus "${movie.title}"?'),
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
                                    provider.deleteMovie(movie.id!);
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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
