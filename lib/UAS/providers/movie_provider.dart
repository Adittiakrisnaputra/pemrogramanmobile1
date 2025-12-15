import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movie.dart';
import '../models/custom_movie.dart';
import '../services/database_service.dart';

enum AppState { idle, loading, success, error }

class MovieProvider with ChangeNotifier {
  // === Bagian API The Movie DB ===
  List<Movie> _popularMovies = [];
  AppState _apiState = AppState.idle;
  String _errorMessage = '';

  List<Movie> get popularMovies => _popularMovies;
  AppState get apiState => _apiState;
  String get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies() async {
    _apiState = AppState.loading;
    notifyListeners();
    try {
      const apiKey = '91047d70a9e178fff278e3fe4d74b0ad';
      const url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final results = json.decode(response.body)['results'] as List;
        _popularMovies = results.map((e) => Movie.fromJson(e)).toList();
        _apiState = AppState.success;
      } else {
        _errorMessage = 'Gagal memuat data: Status code ${response.statusCode}';
        _apiState = AppState.error;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      _apiState = AppState.error;
    }
    notifyListeners();
  }

  Future<String?> fetchMovieTrailer(int movieId) async {
    // ... (kode trailer Anda sudah benar, tidak perlu diubah)
    // ...
  }


  // === Bagian Database Lokal (SQLite) ===
  List<CustomMovie> _customMovies = [];

  // Getter untuk semua film yang disimpan
  List<CustomMovie> get customMovies => _customMovies;

  // Getter untuk film favorit
  List<CustomMovie> get favoriteMovies => _customMovies.where((movie) => movie.isFavorite).toList();

  // FUNGSI UNTUK MEMBACA SEMUA FILM DARI DB DAN MEMPERBARUI UI
  Future<void> fetchCustomMovies() async {
    _customMovies = await DatabaseService.instance.readAllMovies();
    notifyListeners(); // <--- INI PENTING! Memberi tahu UI untuk update
  }

  // FUNGSI UNTUK MENAMBAH FILM
  Future<void> addMovie(CustomMovie movie) async {
    await DatabaseService.instance.createMovie(movie);
    // Setelah menambah, panggil ulang fetch untuk memperbarui daftar film di aplikasi
    await fetchCustomMovies(); // <--- BARIS INI DIPASTIKAN ADA
  }

  // FUNGSI UNTUK MEMPERBARUI FILM (misal: mengubah status favorit)
  Future<void> updateMovie(CustomMovie movie) async {
    await DatabaseService.instance.updateMovie(movie);
    // Panggil ulang fetch untuk memperbarui item di daftar
    await fetchCustomMovies(); // <--- BARIS INI DIPASTIKAN ADA
  }

  // FUNGSI UNTUK MENGHAPUS FILM
  Future<void> deleteMovie(int id) async {
    await DatabaseService.instance.deleteMovie(id);
    // Panggil ulang fetch untuk menghapus item dari daftar
    await fetchCustomMovies(); // <--- BARIS INI DIPASTIKAN ADA
  }
}
