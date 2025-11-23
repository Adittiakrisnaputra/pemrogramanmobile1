// Lokasi: lib/tugas 5 latihan 1/services/todo_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart'; // Path relatif untuk import

class TodoService {
  static const _storageKey = 'todos_storage';

  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString(_storageKey);
    if (todosString != null) {
      final List<dynamic> todoListJson = json.decode(todosString);
      return todoListJson.map((json) => Todo.fromMap(json)).toList();
    }
    return [];
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todoListJson = todos.map((todo) => todo.toMap()).toList();
    await prefs.setString(_storageKey, json.encode(todoListJson));
  }
}
