// Lokasi: lib/tugas 5 latihan 2/models/shopping_item.dart
import 'dart:convert';

enum ItemCategory { makanan, minuman, elektronik, rumahTangga, lainnya }

class ShoppingItem {
  String id;
  String name;
  int quantity;
  ItemCategory category;
  bool isBought;

  ShoppingItem({
    required this.id,
    required this.name,
    this.quantity = 1,
    this.category = ItemCategory.lainnya,
    this.isBought = false,
  });

  static String categoryToString(ItemCategory category) {
    return category.toString().split('.').last;
  }

  static ItemCategory stringToCategory(String? categoryString) {
    return ItemCategory.values.firstWhere(
          (e) => e.toString().split('.').last == categoryString,
      orElse: () => ItemCategory.lainnya,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': categoryToString(category),
      'isBought': isBought,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 1,
      category: stringToCategory(map['category']),
      isBought: map['isBought'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingItem.fromJson(String source) => ShoppingItem.fromMap(json.decode(source));
}
