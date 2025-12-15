import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {  final String posterUrl;
final VoidCallback onTap;

const MovieCard({
  super.key,
  required this.posterUrl,
  required this.onTap,
});

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        posterUrl,
        fit: BoxFit.cover,
        // Loading builder untuk user experience yang lebih baik
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        // Error builder jika gambar gagal dimuat
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            child: const Center(
              child: Icon(Icons.movie, color: Colors.white, size: 40),
            ),
          );
        },
      ),
    ),
  );
}
}
