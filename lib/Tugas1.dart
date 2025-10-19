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
          backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Biodata saya :)"),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "BIODATA",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    NetworkImage("data:image/jpeg;base64,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"),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: const [
                      Icon(Icons.person, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text(
                        "Nama: Adittia Krisna Putra",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row (
                    children: const [
                      Icon(Icons.wallet_travel, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        "Prodi: Sistem Informasi",
                        style: TextStyle(fontSize: 16),
                      ),
                    ]
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(" Klik Saya "),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
