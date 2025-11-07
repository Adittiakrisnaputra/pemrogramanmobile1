import 'package:flutter/material.dart';
// Impor file halaman kedua (hasil_feedback.dart)
import 'package:pemrogramanmobile1/hasil_feedback.dart';// --- TITIK AWAL APLIKASI ---
// Fungsi main() membuat file ini bisa dijalankan secara langsung.
void main() {
  runApp(const MyApp());
}

// Widget pembungkus utama yang berisi MaterialApp.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Feedback App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      // Halaman utama aplikasi adalah FormFeedbackPage.
      home: const FormFeedbackPage(),
    );
  }
}

// --- HALAMAN FORMULIR ---
class FormFeedbackPage extends StatefulWidget {
  const FormFeedbackPage({Key? key}) : super(key: key);

  @override
  State<FormFeedbackPage> createState() => _FormFeedbackPageState();
}

class _FormFeedbackPageState extends State<FormFeedbackPage> {
  // GlobalKey untuk validasi form.
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil teks dari input.
  final _namaController = TextEditingController();
  final _komentarController = TextEditingController();

  // Variabel untuk menyimpan nilai rating yang dipilih.
  int _rating = 0;

  // Fungsi yang dijalankan saat tombol "Kirim" ditekan.
  void _kirimFeedback() {
    // Jalankan validasi pada semua TextFormField.
    if (_formKey.currentState!.validate()) {
      // Periksa apakah pengguna sudah memberikan rating.
      if (_rating == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mohon berikan rating bintang terlebih dahulu!'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return; // Hentikan fungsi jika rating belum diisi.
      }

      // Jika semua valid, pindah ke halaman hasil (Halaman 2).
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HasilFeedbackPage(
            nama: _namaController.text,
            komentar: _komentarController.text,
            rating: _rating,
          ),
        ),
      );
    }
  }

  // Bersihkan controller untuk manajemen memori.
  @override
  void dispose() {
    _namaController.dispose();
    _komentarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback Pelanggan'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white, // Menambahkan warna teks agar kontras
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Kami Menghargai Masukan Anda',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Bantu kami menjadi lebih baik dengan mengisi form di bawah ini.',
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Input Nama
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Input Komentar
              TextFormField(
                controller: _komentarController,
                decoration: const InputDecoration(
                  labelText: 'Komentar atau Masukan Anda',
                  prefixIcon: Icon(Icons.comment_outlined),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Komentar tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Input Rating Bintang
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Seberapa Puas Anda dengan Layanan Kami?',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            onPressed: () {
                              // Memperbarui rating menggunakan setState()
                              setState(() {
                                _rating = index + 1;
                              });
                            },
                            icon: Icon(
                              index < _rating ? Icons.star_rounded : Icons.star_border_rounded,
                              color: Colors.amber,
                              size: 40,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Kirim
              ElevatedButton.icon(
                onPressed: _kirimFeedback,
                icon: const Icon(Icons.send_rounded),
                label: const Text('KIRIM FEEDBACK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
