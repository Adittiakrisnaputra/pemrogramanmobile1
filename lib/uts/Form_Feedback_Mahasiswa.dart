import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Home_Page.dart'; // Untuk mengakses globalFeedbackList
import 'models.dart';

class FormFeedbackMahasiswa extends StatefulWidget {
  const FormFeedbackMahasiswa({Key? key}) : super(key: key);

  @override
  State<FormFeedbackMahasiswa> createState() => _FormFeedbackMahasiswaState();
}

class _FormFeedbackMahasiswaState extends State<FormFeedbackMahasiswa> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _pesanController = TextEditingController();

  String? _fakultas;
  final Map<String, bool> _fasilitas = {
    'WIFI Kampus': false, 'Perpustakaan': false, 'Kantin': false, 'Area Parkir': false,
  };
  double _nilaiKepuasan = 3.0;
  String _jenisFeedback = 'Saran';
  bool _setujuSyarat = false;

  final List<String> _pilihanFakultas = [
    'Tarbiyah dan Keguruan', 'Syariah', 'Ushuluddin dan Studi Agama',
    'Ekonomi dan Bisnis Islam', 'Adab dan Humaniora', 'Dakwah', 'Sains dan Teknologi',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _pesanController.dispose();
    super.dispose();
  }

  void _simpanFeedback() {
    if (_formKey.currentState!.validate()) {
      if (!_setujuSyarat) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Persetujuan Diperlukan'),
            content: const Text('Anda harus menyetujui Syarat & Ketentuan.'),
            actions: [
              TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Mengerti')),
            ],
          ),
        );
        return;
      }

      final newFeedback = FeedbackModel(
        nama: _namaController.text,
        nim: _nimController.text,
        fakultas: _fakultas!,
        fasilitas: _fasilitas.entries.where((e) => e.value).map((e) => e.key).toList(),
        nilaiKepuasan: _nilaiKepuasan,
        jenisFeedback: _jenisFeedback,
        pesan: _pesanController.text,
        setujuSyarat: _setujuSyarat,
      );

      globalFeedbackList.add(newFeedback);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback berhasil disimpan!'), backgroundColor: Colors.green),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulir Feedback")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Mahasiswa', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM', border: OutlineInputBorder(), prefixIcon: Icon(Icons.numbers)),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) => v == null || v.isEmpty ? 'NIM wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _fakultas,
                decoration: const InputDecoration(labelText: 'Fakultas', border: OutlineInputBorder(), prefixIcon: Icon(Icons.school)),
                items: _pilihanFakultas.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (v) => setState(() => _fakultas = v),
                validator: (v) => v == null ? 'Fakultas wajib dipilih' : null,
              ),
              const SizedBox(height: 24),
              const Text('Fasilitas yang Dinilai:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ..._fasilitas.keys.map((key) => CheckboxListTile(
                title: Text(key), value: _fasilitas[key], onChanged: (val) => setState(() => _fasilitas[key] = val!),
              )).toList(),
              const SizedBox(height: 24),
              const Text('Nilai Kepuasan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Slider(
                value: _nilaiKepuasan, min: 1, max: 5, divisions: 4,
                label: _nilaiKepuasan.round().toString(),
                onChanged: (val) => setState(() => _nilaiKepuasan = val),
              ),
              const SizedBox(height: 24),
              const Text('Jenis Feedback:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              RadioListTile<String>(title: const Text('Saran'), value: 'Saran', groupValue: _jenisFeedback, onChanged: (v) => setState(() => _jenisFeedback = v!)),
              RadioListTile<String>(title: const Text('Keluhan'), value: 'Keluhan', groupValue: _jenisFeedback, onChanged: (v) => setState(() => _jenisFeedback = v!)),
              RadioListTile<String>(title: const Text('Apresiasi'), value: 'Apresiasi', groupValue: _jenisFeedback, onChanged: (v) => setState(() => _jenisFeedback = v!)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pesanController,
                decoration: const InputDecoration(labelText: 'Pesan Tambahan (Opsional)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.message)),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Saya menyetujui Syarat & Ketentuan'),
                value: _setujuSyarat,
                onChanged: (val) => setState(() => _setujuSyarat = val),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _simpanFeedback,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                child: const Text('Simpan Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
