// Lokasi: lib/tugas 5 latihan 2/screens/shopping_list_screen.dart
import 'package:flutter/material.dart';
import '../models/shopping_item.dart'; // Path relatif yang benar
import '../services/storage_service.dart'; // Path relatif yang benar
import '../widgets/summary_card.dart'; // Path relatif yang benar

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final StorageService _storageService = StorageService();
  List<ShoppingItem> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() => _isLoading = true);
    _items = await _storageService.getItems();
    _items.sort((a, b) => a.isBought ? 1 : -1);
    setState(() => _isLoading = false);
  }

  Future<void> _saveItems() async {
    _items.sort((a, b) => a.isBought ? 1 : -1);
    await _storageService.saveItems(_items);
    setState(() {});
  }

  void _addItem(String name, int quantity, ItemCategory category) {
    final newItem = ShoppingItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      quantity: quantity,
      category: category,
    );
    setState(() => _items.add(newItem));
    _saveItems();
  }

  void _toggleItemStatus(ShoppingItem item) {
    setState(() => item.isBought = !item.isBought);
    _saveItems();
  }

  void _deleteItem(ShoppingItem item) {
    setState(() => _items.removeWhere((i) => i.id == item.id));
    _saveItems();
  }

  void _showItemDialog({ShoppingItem? item}) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    ItemCategory selectedCategory = ItemCategory.makanan;

    showDialog(
      context: context,
      builder: (context) {
        // StatefulBuilder diperlukan agar Dropdown bisa update di dalam dialog
        return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Tambah Item Baru'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama Item'), autofocus: true),
                      TextField(controller: quantityController, decoration: const InputDecoration(labelText: 'Jumlah'), keyboardType: TextInputType.number),
                      DropdownButton<ItemCategory>(
                        value: selectedCategory,
                        isExpanded: true,
                        onChanged: (ItemCategory? newValue) {
                          setDialogState(() { // Gunakan setDialogState untuk update UI dialog
                            selectedCategory = newValue!;
                          });
                        },
                        items: ItemCategory.values.map<DropdownMenuItem<ItemCategory>>((ItemCategory value) {
                          return DropdownMenuItem<ItemCategory>(
                            value: value,
                            child: Text(ShoppingItem.categoryToString(value)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text;
                      final quantity = int.tryParse(quantityController.text) ?? 1;
                      if (name.isNotEmpty) {
                        _addItem(name, quantity, selectedCategory);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              );
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalItems = _items.length;
    final int boughtItems = _items.where((item) => item.isBought).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Belanja'), centerTitle: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SummaryCard(totalItems: totalItems, boughtItems: boughtItems),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.list_alt_rounded),
                SizedBox(width: 8),
                Text('Daftar Item', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? const Center(child: Text('Daftar belanja masih kosong.'))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  color: item.isBought ? Colors.grey.shade300 : null,
                  child: ListTile(
                    leading: Checkbox(value: item.isBought, onChanged: (_) => _toggleItemStatus(item)),
                    title: Text(item.name, style: TextStyle(decoration: item.isBought ? TextDecoration.lineThrough : TextDecoration.none)),
                    subtitle: Text('Kategori: ${ShoppingItem.categoryToString(item.category)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('x${item.quantity}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _deleteItem(item),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: _showItemDialog,
          tooltip: 'Tambah Item',
          child: const Icon(Icons.add_shopping_cart),
        ),
      ),

    );
  }
}
