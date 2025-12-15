import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Selamat datang di biodata saya"),
          centerTitle: true,

        ),
        // ... (kode sebelumnya)

        body: Center(
          // Menggunakan Card agar tampilan biodata lebih menonjol
          child: Card(
            elevation: 8.0, // Memberi efek bayangan pada card
            margin: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Membuat Column sesuai ukuran children
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  const Text(
                    "BIODATA",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: const [
                      Icon(Icons.person, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text(
                        "Nama: Adittia krisna putra",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: const [
                      Icon(Icons.school, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        "NIM: 701230037",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.videogame_asset, color: Colors.redAccent),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Hobi: Bermain Game online dan jalan-jalan",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: null,
      ),
    );
  }
}
