import 'package:flutter/material.dart';
import 'input_page.dart'; // Import halaman input untuk navigasi

// ==========================================================
// HALAMAN UTAMA DENGAN BOTTOM NAVIGATION BAR
// ==========================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar tampilan yang akan ditampilkan sesuai item yang dipilih
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(), // Konten untuk tab 'Home'
    ProfileScreenContent(), // Konten untuk tab 'Profile'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Utama'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Spesifikasi: Menggunakan BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Konten untuk Tab "Home" di HomePage
class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.navigation, size: 100, color: Colors.black26),
            const SizedBox(height: 20),
            const Text(
              'Demo Navigasi Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Mulai Kirim Data'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              // Spesifikasi: Menggunakan Navigator.push()
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Konten untuk Tab "Profile" di HomePage
class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_pin_rounded, size: 100, color: Colors.black26),
          SizedBox(height: 20),
          Text(
            'Ini Halaman Profil',
            style: TextStyle(fontSize: 22, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
