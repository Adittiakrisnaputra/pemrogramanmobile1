// lib/uts/Detail_Feedback.dart

import 'package:flutter/material.dart';
import 'models.dart';

class DetailFeedback extends StatelessWidget {
  final FeedbackModel feedback;
  final VoidCallback onDelete;

  const DetailFeedback({
    Key? key,
    required this.feedback,
    required this.onDelete,
  }) : super(key: key);

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const Divider(height: 10),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus feedback ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onDelete();
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Feedback')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoRow(context, 'Nama Mahasiswa', feedback.nama),
            _buildInfoRow(context, 'NIM', feedback.nim),
            _buildInfoRow(context, 'Fakultas', feedback.fakultas),
            _buildInfoRow(context, 'Fasilitas yang Dinilai', feedback.fasilitas.isEmpty ? '-' : feedback.fasilitas.join(', ')),
            _buildInfoRow(context, 'Nilai Kepuasan', '${feedback.nilaiKepuasan.toStringAsFixed(1)} / 5.0'),
            _buildInfoRow(context, 'Jenis Feedback', feedback.jenisFeedback),
            _buildInfoRow(context, 'Pesan Tambahan', feedback.pesan.isEmpty ? '-' : feedback.pesan),
            _buildInfoRow(context, 'Persetujuan S&K', feedback.setujuSyarat ? 'Setuju' : 'Tidak Setuju'),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke Daftar'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _showDeleteConfirmation(context),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
              child: const Text('Hapus Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
