import 'dart:convert';

class Movie {  final int id;
final String title;
final String overview;
final String posterPath;
final double voteAverage;
final DateTime releaseDate; // Menggunakan objek DateTime

Movie({
  required this.id,
  required this.title,
  required this.overview,
  required this.posterPath,
  required this.voteAverage,
  required this.releaseDate,
});

factory Movie.fromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'],
    title: json['title'] ?? 'No Title',
    overview: json['overview'] ?? 'No Overview',
    // Menambahkan URL dasar untuk posterPath
    posterPath: json['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
        : 'https://via.placeholder.com/500x750.png?text=No+Image',
    voteAverage: (json['vote_average'] as num).toDouble(),
    // Parsing tanggal, beri nilai default jika null atau format salah
    releaseDate: DateTime.tryParse(json['release_date'] ?? '') ?? DateTime.now(),
  );
}
}
