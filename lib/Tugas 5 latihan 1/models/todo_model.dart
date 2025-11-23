import 'dart:convert';

class Todo {
  String id;
  String title;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // Fungsi ini membutuhkan 'dart:convert'
  String toJson() => json.encode(toMap());

  // Fungsi ini juga membutuhkan 'dart:convert'
  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
