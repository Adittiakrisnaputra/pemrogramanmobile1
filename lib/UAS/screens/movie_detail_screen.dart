import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pemrogramanmobile1/UAS/models/custom_movie.dart';
import 'package:pemrogramanmobile1/UAS/models/movie.dart';
import 'package:pemrogramanmobile1/UAS/providers/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    movie.posterPath,
                    height: 400,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.movie, size: 400, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Rilis: ${movie.releaseDate.day}-${movie.releaseDate.month}-${movie.releaseDate.year}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    'Rating: ${movie.voteAverage.toStringAsFixed(1)}/10',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Sinopsis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                movie.overview.isNotEmpty
                    ? movie.overview
                    : 'Sinopsis tidak tersedia.',
                style: const TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_to_photos_rounded),
                  label: const Text('Tambah ke Daftar Saya'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    // Cek apakah film sudah ada di daftar
                    final provider = Provider.of<MovieProvider>(context, listen: false);
                    bool isAlreadyAdded = provider.customMovies.any((m) => m.title == movie.title);

                    if (isAlreadyAdded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Film ini sudah ada di daftar Anda.'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    } else {
                      final customMovie = CustomMovie(
                        title: movie.title,
                        director: 'N/A',
                        year: movie.releaseDate.year,
                        posterUrl: movie.posterPath,
                        isFavorite: false, // Default tidak favorit
                      );

                      provider.addMovie(customMovie);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Film berhasil ditambahkan!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
