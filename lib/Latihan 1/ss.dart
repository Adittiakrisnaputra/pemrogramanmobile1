import 'package:flutter/material.dart';
import 'screens/note_list_screens.dart';

void main() {
  runApp(const NotesApp());
}

// Ini 'body' mobil Anda (MaterialApp)
class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Catatan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      // Ini memberitahu mobil untuk menggunakan 'roda' NoteListScreen
      home: NoteListScreen(),
    );
  }
}
    