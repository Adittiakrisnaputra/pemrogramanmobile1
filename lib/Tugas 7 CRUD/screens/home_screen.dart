import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import '../providers/theme_provider.dart';
import 'note_editor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _allNotes = [];
  List<Note> _filteredNotes = [];
  NoteCategory? _selectedCategoryFilter;

  // Kunci untuk menyimpan data di SharedPreferences
  static const NOTES_KEY = "notes_data_tugas7";

  @override
  void initState() {
    super.initState();
    // Langsung muat catatan dari SharedPreferences saat layar dibuka
    _loadNotes();
  }

  // --- LOGIKA CRUD DENGAN SHAREDPREFERENCES ---

  // CREATE (Membuat) & UPDATE (Memperbarui)
  void _navigateAndManageNote(BuildContext context, {Note? note}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditorScreen(note: note)),
    );

    if (result != null && result is Note) {
      setState(() {
        if (note != null) { // Mode UPDATE
          final index = _allNotes.indexWhere((n) => n.id == result.id);
          if (index != -1) _allNotes[index] = result;
        } else { // Mode CREATE
          _allNotes.add(result);
        }
        _saveNotes(); // Simpan perubahan ke SharedPreferences
      });
    }
  }

  // READ (Membaca) dari SharedPreferences
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getStringList(NOTES_KEY) ?? [];
    setState(() {
      _allNotes.clear();
      _allNotes.addAll(notesData.map((noteJson) => Note.fromJson(noteJson)));
      _filterNotes(_selectedCategoryFilter);
    });
  }

  // DELETE (Menghapus)
  void _deleteNote(String id) {
    setState(() {
      _allNotes.removeWhere((note) => note.id == id);
      _saveNotes(); // Simpan perubahan ke SharedPreferences
    });
  }

  // Fungsi internal untuk MENYIMPAN semua catatan ke SharedPreferences
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJsonList = _allNotes.map((note) => note.toJson()).toList();
    await prefs.setStringList(NOTES_KEY, notesJsonList);
    _filterNotes(_selectedCategoryFilter); // Perbarui UI setelah menyimpan
  }

  // --- AKHIR LOGIKA CRUD ---

  void _filterNotes(NoteCategory? category) {
    setState(() {
      _selectedCategoryFilter = category;
      if (category == null) {
        _filteredNotes = _allNotes;
      } else {
        _filteredNotes = _allNotes.where((note) => note.category == category).toList();
      }
    });
  }

  IconData _getIconForCategory(NoteCategory category) {
    switch (category) {
      case NoteCategory.kuliah: return Icons.school;
      case NoteCategory.organisasi: return Icons.group;
      case NoteCategory.pribadi: return Icons.person;
      case NoteCategory.lainLain: return Icons.lightbulb_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil theme provider agar bisa digunakan untuk toggle
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Catatan Mahasiswa'),
        actions: [
          // --- TOMBOL TOGGLE DARK MODE (BONUS) ---
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            tooltip: 'Ganti Tema',
            onPressed: () {
              // Panggil fungsi toggleTheme dari provider
              themeProvider.toggleTheme();
            },
          ),
          // --- AKHIR TOMBOL TOGGLE ---

          // Dropdown Filter
          DropdownButtonHideUnderline(
            child: DropdownButton<NoteCategory>(
              hint: const Text('Filter', style: TextStyle(color: Colors.white)),
              value: _selectedCategoryFilter,
              icon: const Icon(Icons.filter_list, color: Colors.white),
              items: NoteCategory.values.map((NoteCategory category) {
                return DropdownMenuItem<NoteCategory>(
                  value: category,
                  child: Text(getCategoryName(category)),
                );
              }).toList(),
              onChanged: (NoteCategory? newValue) {
                _filterNotes(newValue);
              },
            ),
          ),
          // Tombol untuk menghapus filter
          if (_selectedCategoryFilter != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _filterNotes(null),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _filteredNotes.isEmpty
          ? const Center(child: Text("Belum ada catatan."))
          : ListView.builder(
        itemCount: _filteredNotes.length,
        itemBuilder: (context, index) {
          final note = _filteredNotes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              leading: Icon(_getIconForCategory(note.category), size: 30),
              title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Dibuat: ${note.date.day}/${note.date.month}/${note.date.year}',
              ),

              // --- PERUBAHAN UTAMA ADA DI SINI ---
              // Mengganti trailing dengan Row yang berisi dua IconButton
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // Penting agar Row tidak error
                children: [
                  // Tombol EDIT (UPDATE)
                  IconButton(
                    icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                    tooltip: 'Edit Catatan',
                    onPressed: () => _navigateAndManageNote(context, note: note),
                  ),
                  // Tombol DELETE
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    tooltip: 'Hapus Catatan',
                    onPressed: () => _deleteNote(note.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0), // <-- Tambahkan padding di bagian bawah
        child: FloatingActionButton(
          onPressed: () => _navigateAndManageNote(context),
          tooltip: 'Tambah Catatan',
          child: const Icon(Icons.add),
        ),
      ),

    );
  }
}
