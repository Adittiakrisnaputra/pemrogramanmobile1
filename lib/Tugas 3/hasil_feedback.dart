import 'package:flutter/material.dart';

// --- TITIK AWAL APLIKASI (UNTUK MENJALANKAN FILE INI SECARA MANDIRI) ---
void main() {
  runApp(const MyAppDetail());
}

class MyAppDetail extends StatelessWidget {
  const MyAppDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hasil Feedback',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      // Menetapkan Halaman Hasil Feedback sebagai halaman utama
      // dan memberinya data contoh untuk ditampilkan saat dijalankan sendiri.
      home: const HasilFeedbackPage(
        nama: "Pengguna Contoh",
        komentar: "Ini adalah komentar contoh untuk pratinjau halaman hasil feedback. Tampilannya sudah bagus dan informatif.",
        rating: 4,
      ),
    );
  }
}

// --- HALAMAN HASIL FEEDBACK ---
class HasilFeedbackPage extends StatefulWidget {
  final String nama;
  final String komentar;
  final int rating;

  const HasilFeedbackPage({
    Key? key,
    required this.nama,
    required this.komentar,
    required this.rating,
  }) : super(key: key);

  @override
  State<HasilFeedbackPage> createState() => _HasilFeedbackPageState();
}

class _HasilFeedbackPageState extends State<HasilFeedbackPage> {
  // State untuk expand/collapse detail komentar
  bool _isKomentarExpanded = false;

  // Helper untuk mendapatkan warna berdasarkan rating
  Color _getRatingColor() {
    if (widget.rating >= 4) return Colors.green;
    if (widget.rating >= 3) return Colors.orange;
    return Colors.red;
  }

  // Helper untuk mendapatkan teks status rating
  String _getRatingText() {
    switch (widget.rating) {
      case 5: return 'Sangat Puas';
      case 4: return 'Puas';
      case 3: return 'Cukup';
      case 2: return 'Kurang Puas';
      default: return 'Tidak Puas';
    }
  }

  // Helper untuk mendapatkan emoji berdasarkan rating
  String _getRatingEmoji() {
    switch (widget.rating) {
      case 5: return '😍';
      case 4: return '😊';
      case 3: return '😐';
      case 2: return '😕';
      default: return '😞';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Hasil Feedback', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Sukses
            _buildSuccessHeader(),
            const SizedBox(height: 30),

            // Card Nama
            _buildInfoCard(
              icon: Icons.person_rounded,
              iconColor: Colors.blue[700]!,
              iconBgColor: Colors.blue.shade50,
              label: 'Nama Pengirim',
              value: widget.nama,
            ),
            const SizedBox(height: 15),

            // Card Rating
            _buildRatingCard(),
            const SizedBox(height: 15),

            // Card Komentar
            _buildKomentarCard(),
            const SizedBox(height: 30),

            // Tombol Kembali
            ElevatedButton.icon(
              onPressed: () {
                // Cek apakah bisa kembali, untuk menghindari error jika halaman ini dibuka langsung
                if (Navigator.canPop(context)) {
                  Navigator.pop(context); // Kembali ke Halaman 1
                }
              },
              icon: const Icon(Icons.arrow_back_rounded, size: 20),
              label: const Text('KEMBALI KE FORM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.check_circle_rounded, size: 80, color: Colors.white),
          SizedBox(height: 20),
          Text('Feedback Berhasil Terkirim!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text('Terima kasih atas waktu dan masukan Anda.', style: TextStyle(fontSize: 15, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required Color iconColor, required Color iconBgColor, required String label, required String value}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: iconColor, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: _getRatingColor().withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.star_rounded, color: _getRatingColor(), size: 30),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rating yang Diberikan', style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('${widget.rating} / 5', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _getRatingColor())),
                          const SizedBox(width: 10),
                          Text(_getRatingEmoji(), style: const TextStyle(fontSize: 22)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: _getRatingColor().withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                  child: Text(_getRatingText(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _getRatingColor())),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => Icon(index < widget.rating ? Icons.star_rounded : Icons.star_outline_rounded, color: Colors.amber[700], size: 32)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKomentarCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.comment_rounded, color: Colors.purple[700], size: 30),
                ),
                const SizedBox(width: 15),
                Text('Detail Komentar', style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                const Spacer(),
                IconButton(
                  icon: Icon(_isKomentarExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 28),
                  onPressed: () => setState(() => _isKomentarExpanded = !_isKomentarExpanded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedCrossFade(
              firstChild: Text(widget.komentar.length > 100 ? '${widget.komentar.substring(0, 100)}...' : widget.komentar, style: const TextStyle(fontSize: 15, height: 1.6)),
              secondChild: Text(widget.komentar, style: const TextStyle(fontSize: 15, height: 1.6)),
              crossFadeState: _isKomentarExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
