const String tableMovies = 'movies';

// Nama-nama kolom di dalam tabel
class MovieFields {
  static final List<String> values = [
    id, title, director, year, posterUrl, isFavorite
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String director = 'director';
  static const String year = 'year';
  static const String posterUrl = 'posterUrl';
  static const String isFavorite = 'isFavorite';
}

// Class Model untuk data film kustom
class CustomMovie {
  final int? id;
  final String title;
  final String director;
  final int year;
  final String posterUrl;
  final bool isFavorite;

  const CustomMovie({
    this.id,
    required this.title,
    required this.director,
    required this.year,
    required this.posterUrl,
    required this.isFavorite,
  });

  // Method untuk membuat objek baru dengan data yang dimodifikasi
  CustomMovie copyWith({
    int? id,
    String? title,
    String? director,
    int? year,
    String? posterUrl,
    bool? isFavorite,
  }) =>
      CustomMovie(
        id: id ?? this.id,
        title: title ?? this.title,
        director: director ?? this.director,
        year: year ?? this.year,
        posterUrl: posterUrl ?? this.posterUrl,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  // == BAGIAN PALING PENTING ==
  // Method untuk mengubah objek menjadi format JSON (untuk disimpan ke DB)
  Map<String, Object?> toJson() => {
    MovieFields.id: id,
    MovieFields.title: title,
    MovieFields.director: director,
    MovieFields.year: year,
    MovieFields.posterUrl: posterUrl,
    // UBAH NILAI BOOLEAN (true/false) MENJADI INTEGER (1/0)
    MovieFields.isFavorite: isFavorite ? 1 : 0,
  };

  // == BAGIAN PALING PENTING ==
  // Method untuk membuat objek dari format JSON (saat membaca dari DB)
  static CustomMovie fromJson(Map<String, Object?> json) => CustomMovie(
    id: json[MovieFields.id] as int?,
    title: json[MovieFields.title] as String,
    director: json[MovieFields.director] as String,
    year: json[MovieFields.year] as int,
    posterUrl: json[MovieFields.posterUrl] as String,
    // UBAH NILAI INTEGER (1) DARI DATABASE KEMBALI MENJADI BOOLEAN (true)
    isFavorite: json[MovieFields.isFavorite] == 1,
  );
}
