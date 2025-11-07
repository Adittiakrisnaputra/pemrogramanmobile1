import 'package:flutter/material.dart';
import 'Home_Page.dart';
import 'models.dart';
import 'Detail_Feedback.dart';

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({Key? key}) : super(key: key);

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  Widget _getFeedbackIcon(String jenis) {
    switch (jenis) {
      case 'Apresiasi': return const Icon(Icons.thumb_up, color: Colors.green);
      case 'Saran': return const Icon(Icons.lightbulb, color: Colors.orange);
      case 'Keluhan': return const Icon(Icons.thumb_down, color: Colors.red);
      default: return const Icon(Icons.comment, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Feedback")),
      body: globalFeedbackList.isEmpty
          ? const Center(child: Text('Belum ada feedback.', style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: globalFeedbackList.length,
        itemBuilder: (context, index) {
          final feedback = globalFeedbackList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                child: _getFeedbackIcon(feedback.jenisFeedback),
              ),
              title: Text(feedback.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(feedback.fakultas),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(feedback.nilaiKepuasan.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailFeedback(
                      feedback: feedback,
                      onDelete: () {
                        setState(() => globalFeedbackList.removeAt(index));
                        Navigator.pop(context); // Kembali setelah hapus
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
