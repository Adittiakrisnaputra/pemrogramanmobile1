import 'dart:convert';
import 'package:http/http.dart' as http;

// Path import sudah disesuaikan
import '../models/movie.dart';

class MovieApiService {
  // !!! GANTI DENGAN API KEY ANDA !!!
  static const String _apiKey = "GANTI_DENGAN_API_KEY_ANDA";
  // ... (sisa kode sama persis)
  static const String _baseUrl = "https://api.themoviedb.org/3";

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat film. Kode Status: ${response.statusCode}');
    }
  }
}
