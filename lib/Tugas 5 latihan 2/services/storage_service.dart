import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shopping_item.dart'; // Path relatif yang benar

class StorageService {
  static const _storageKey = 'shopping_list_v2'; // Kunci unik untuk tugas ini

  Future<List<ShoppingItem>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsString = prefs.getString(_storageKey);
    if (itemsString != null) {
      final List<dynamic> itemsJson = json.decode(itemsString);
      return itemsJson.map((json) => ShoppingItem.fromMap(json)).toList();
    }
    return [];
  }

  Future<void> saveItems(List<ShoppingItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> itemsJson = items.map((item) => item.toMap()).toList();
    await prefs.setString(_storageKey, json.encode(itemsJson));
  }
}
