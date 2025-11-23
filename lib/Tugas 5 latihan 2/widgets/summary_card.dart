// Lokasi: lib/tugas 5 latihan 2/widgets/summary_card.dart
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int totalItems;
  final int boughtItems;

  const SummaryCard({
    super.key,
    required this.totalItems,
    required this.boughtItems,
  });

  @override
  Widget build(BuildContext context) {
    final int unboughtItems = totalItems - boughtItems;
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem(context, 'Total Item', totalItems.toString(), Colors.blue),
            _buildSummaryItem(context, 'Dibeli', boughtItems.toString(), Colors.green),
            _buildSummaryItem(context, 'Belum', unboughtItems.toString(), Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
