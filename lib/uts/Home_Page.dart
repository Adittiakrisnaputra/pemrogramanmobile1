// lib/uts/Home_Page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models.dart';
import 'Form_Feedback_Mahasiswa.dart';
import 'Feedback_List_Page.dart';
import 'about_page.dart';

List<FeedbackModel> globalFeedbackList = [];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const UtsApp());
}

class UtsApp extends StatelessWidget {
  const UtsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTS Feedback Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beranda")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Header Aplikasi ---
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.black12,
                      backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/0/0d/Logo_UIN_STS_Jambi.jpg",
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Aplikasi Feedback Mahasiswa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- Tombol Navigasi ---
              ElevatedButton.icon(
                icon: const Icon(Icons.edit_note),
                label: const Text('Beri Feedback Baru'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FormFeedbackMahasiswa()),
                  ).then((_) {
                    setState(() {});
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),
              if (globalFeedbackList.isNotEmpty)
                ElevatedButton.icon(
                  icon: const Icon(Icons.list_alt),
                  label: Text('Lihat Daftar Feedback (${globalFeedbackList.length})'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackListPage()),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

              if (globalFeedbackList.isNotEmpty) const SizedBox(height: 16),

              OutlinedButton.icon(
                icon: const Icon(Icons.info_outline),
                label: const Text('Tentang Aplikasi'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  side: const BorderSide(color: Colors.deepPurple),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 60),

              // --- Teks Motivasi di Bagian Bawah ---
              const Text(
                '"Setiap feedback adalah hadiah untuk perbaikan."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
