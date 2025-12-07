import 'dart:convert'; // -> Diperlukan untuk konversi JSON

// Enum untuk Kategori
enum NoteCategory {
  kuliah,
  organisasi,
  pribadi,
  lainLain,
}

// Fungsi untuk mendapatkan nama yang mudah dibaca
String getCategoryName(NoteCategory category) {
  switch (category) {
    case NoteCategory.kuliah:
      return 'Kuliah';
    case NoteCategory.organisasi:
      return 'Organisasi';
    case NoteCategory.pribadi:
      return 'Pribadi';
    case NoteCategory.lainLain:
      return 'Lain-lain';
  }
}

class Note {
  String id;
  String title;
  String content;
  DateTime date;
  NoteCategory category;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
  });

  // --- FUNGSI BONUS UNTUK SHAREDPREFERENCES ---
  // Mengubah objek Note menjadi String format JSON untuk disimpan
  String toJson() {
    return jsonEncode({
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(), // Simpan tanggal sebagai string standar
      'category': category.name, // Simpan enum sebagai namanya
    });
  }

  // Membuat objek Note dari String format JSON yang diambil dari penyimpanan
  factory Note.fromJson(String source) {
    Map<String, dynamic> map = jsonDecode(source);
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      category: NoteCategory.values.firstWhere((e) => e.name == map['category']),
    );
  }
// --- AKHIR DARI FUNGSI BONUS ---
}
