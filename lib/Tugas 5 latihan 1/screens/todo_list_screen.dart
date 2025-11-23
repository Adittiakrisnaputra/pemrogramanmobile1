// Lokasi: lib/tugas 5 latihan 1/screens/todo_list_screen.dart
import 'package:flutter/material.dart';
import '../models/todo_model.dart'; // Path relatif
import '../services/todo_service.dart'; // Path relatif

enum TodoFilter { all, completed, incomplete }

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoService _todoService = TodoService();
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  bool _isLoading = true;
  TodoFilter _currentFilter = TodoFilter.all;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() => _isLoading = true);
    _todos = await _todoService.getTodos();
    _applyFilter();
    setState(() => _isLoading = false);
  }

  Future<void> _saveTodos() async {
    await _todoService.saveTodos(_todos);
    _applyFilter();
  }

  void _applyFilter() {
    setState(() {
      if (_currentFilter == TodoFilter.completed) {
        _filteredTodos = _todos.where((todo) => todo.isCompleted).toList();
      } else if (_currentFilter == TodoFilter.incomplete) {
        _filteredTodos = _todos.where((todo) => !todo.isCompleted).toList();
      } else {
        _filteredTodos = List.from(_todos);
      }
    });
  }

  void _addTodo(String title) {
    if (title.isNotEmpty) {
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      );
      setState(() => _todos.add(newTodo));
      _saveTodos();
    }
  }

  void _toggleTodoStatus(Todo todo) {
    setState(() => todo.isCompleted = !todo.isCompleted);
    _saveTodos();
  }

  void _deleteTodo(Todo todo) {
    setState(() => _todos.removeWhere((t) => t.id == todo.id));
    _saveTodos();
  }

  void _editTodo(Todo todo, String newTitle) {
    if (newTitle.isNotEmpty) {
      setState(() => todo.title = newTitle);
      _saveTodos();
    }
  }

  void _showTodoDialog({Todo? todo}) {
    final controller = TextEditingController(text: todo?.title ?? '');
    final isEditing = todo != null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Todo' : 'Tambah Todo Baru'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Judul Todo'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (isEditing) {
                _editTodo(todo, controller.text);
              } else {
                _addTodo(controller.text);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List App'),
        actions: [
          PopupMenuButton<TodoFilter>(
            initialValue: _currentFilter,
            onSelected: (filter) => setState(() {
              _currentFilter = filter;
              _applyFilter();
            }),
            icon: const Icon(Icons.filter_list),
            itemBuilder: (context) => [
              const PopupMenuItem(value: TodoFilter.all, child: Text('Semua')),
              const PopupMenuItem(value: TodoFilter.completed, child: Text('Selesai')),
              const PopupMenuItem(value: TodoFilter.incomplete, child: Text('Belum Selesai')),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredTodos.isEmpty
          ? Center(child: Text('Tidak ada tugas.', style: TextStyle(color: Colors.grey[600])))
          : ListView.builder(
        itemCount: _filteredTodos.length,
        itemBuilder: (context, index) {
          final todo = _filteredTodos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => _toggleTodoStatus(todo),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  color: todo.isCompleted ? Colors.grey : null,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showTodoDialog(todo: todo),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTodo(todo),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // +++ KODE BARU (SOLUSI) +++
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: () => _showTodoDialog(),
          tooltip: 'Tambah Todo',
          child: const Icon(Icons.add),
        ),
      ),

    );
  }
}
