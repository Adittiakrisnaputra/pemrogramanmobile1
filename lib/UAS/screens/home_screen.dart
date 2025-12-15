import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pemrogramanmobile1/UAS/models/custom_movie.dart';
import 'package:pemrogramanmobile1/UAS/models/movie.dart';
import 'package:pemrogramanmobile1/UAS/providers/movie_provider.dart';
// Perbaikan path import, pastikan nama file sudah benar
import 'package:pemrogramanmobile1/UAS/screens/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchPopularMovies();
    });
  }

  void _showOptionsDialog(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Apa yang ingin Anda lakukan?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Lihat Detail'),
              onPressed: () {
                Navigator.of(ctx).pop();
                // Menggunakan 'MovieDetailScreen' dengan benar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Tambah ke Favorit'),
              onPressed: () {
                final movieProvider = Provider.of<MovieProvider>(context, listen: false);

                final customMovie = CustomMovie(
                  title: movie.title,
                  director: 'N/A',
                  // Menggunakan 'movie.releaseDate.year' dengan benar
                  year: movie.releaseDate.year,
                  posterUrl: movie.posterPath,
                  isFavorite: true,
                );

                movieProvider.addMovie(customMovie);
                Navigator.of(ctx).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${movie.title}" ditambahkan ke favorit!'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.apiState == AppState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.apiState == AppState.error) {
            return Center(
              child: Text(
                'Gagal memuat film.\n${provider.errorMessage}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (provider.popularMovies.isEmpty) {
            return const Center(child: Text('Tidak ada film populer saat ini.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: provider.popularMovies.length,
            itemBuilder: (context, index) {
              final movie = provider.popularMovies[index];
              return GestureDetector(
                onTap: () {
                  _showOptionsDialog(context, movie);
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.posterPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.movie, color: Colors.grey, size: 50));
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10.0).copyWith(top: 20),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black, Colors.transparent],
                            ),
                          ),
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
