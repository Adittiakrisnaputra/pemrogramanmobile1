// Lokasi: lib/Tugas 6/screens/registration_screen.dart
import 'package:flutter/material.dart';
import '../models/registration_data.dart'; // Sesuaikan path import

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;

  // Satu GlobalKey untuk setiap Step di dalam Stepper
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // Inisialisasi objek data dari model
  final _data = RegistrationData();

  final List<String> _majors = ['Teknik Informatika', 'Sistem Informasi', 'Manajemen', 'Akuntansi'];

  void _onStepContinue() {
    // Validasi form pada step saat ini sebelum melanjutkan
    if (_formKeys[_currentStep].currentState!.validate()) {
      _formKeys[_currentStep].currentState!.save(); // Simpan data jika valid

      // Jika bukan step terakhir, maju ke step berikutnya
      if (_currentStep < _getSteps().length - 1) {
        setState(() {
          _currentStep += 1;
        });
      } else {
        // Jika sudah di step terakhir, proses data (misal: tampilkan dialog)
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Data Berhasil Dikirim'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Nama: ${_data.name}'),
                  Text('Email: ${_data.email}'),
                  Text('No. HP: ${_data.phoneNumber}'),
                  Text('Jurusan: ${_data.major}'),
                  Text('Semester: ${_data.semester.toInt()}'),
                  Text('Hobi: ${_data.hobbies.entries.where((e) => e.value).map((e) => e.key).join(', ')}'),
                  Text('Persetujuan: ${_data.agreesToTerms ? "Ya" : "Tidak"}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset form ke awal setelah dialog ditutup
                  setState(() {
                    _currentStep = 0;
                  });
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Mahasiswa Validasi'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        onStepTapped: (step) => setState(() => _currentStep = step),
        steps: _getSteps(),
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          // Kustomisasi teks tombol
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep == _getSteps().length - 1 ? 'KIRIM' : 'LANJUT'),
                ),
                if (_currentStep != 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('KEMBALI'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk membangun daftar Step
  List<Step> _getSteps() {
    return [
      // === LANGKAH 1: DATA PRIBADI ===
      Step(
        title: const Text('Data Pribadi'),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeys[0],
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) => (value == null || value.isEmpty) ? 'Nama tidak boleh kosong' : null,
                onSaved: (value) => _data.name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Format email tidak valid';
                  return null;
                },
                onSaved: (value) => _data.email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nomor HP'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Nomor HP tidak boleh kosong';
                  if (value.length < 10) return 'Nomor HP minimal 10 digit';
                  return null;
                },
                onSaved: (value) => _data.phoneNumber = value!,
              ),
            ],
          ),
        ),
      ),
      // === LANGKAH 2: DATA AKADEMIK & MINAT ===
      Step(
        title: const Text('Data Akademik & Minat'),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeys[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Jurusan'),
                value: _data.major,
                items: _majors.map((major) => DropdownMenuItem(value: major, child: Text(major))).toList(),
                onChanged: (value) => setState(() => _data.major = value),
                validator: (value) => value == null ? 'Jurusan harus dipilih' : null,
              ),
              const SizedBox(height: 24),
              const Text('Semester'),
              Slider(
                value: _data.semester,
                min: 1,
                max: 8,
                divisions: 7,
                label: _data.semester.round().toString(),
                onChanged: (value) => setState(() => _data.semester = value),
              ),
              const SizedBox(height: 16),
              const Text('Hobi'),
              ..._data.hobbies.keys.map((key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: _data.hobbies[key],
                  onChanged: (value) => setState(() => _data.hobbies[key] = value!),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                );
              }).toList(),
              // Validasi untuk Hobi (minimal pilih 1)
              FormField<bool>(
                builder: (state) => state.hasError ? Text(state.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)) : Container(),
                validator: (value) => !_data.hobbies.values.contains(true) ? 'Pilih minimal satu hobi' : null,
              ),
            ],
          ),
        ),
      ),
      // === LANGKAH 3: PERSETUJUAN ===
      Step(
        title: const Text('Persetujuan'),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeys[2],
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Saya setuju dengan syarat dan ketentuan.'),
                value: _data.agreesToTerms,
                onChanged: (value) => setState(() => _data.agreesToTerms = value),
                subtitle: _data.agreesToTerms ? const Text('Anda telah setuju') : null,
              ),
              // Validasi untuk Switch
              FormField<bool>(
                builder: (state) {
                  if (state.hasError) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(state.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)),
                    );
                  }
                  return Container();
                },
                validator: (value) => !_data.agreesToTerms ? 'Anda harus menyetujui syarat dan ketentuan' : null,
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
