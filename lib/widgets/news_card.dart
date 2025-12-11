import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String category;
  final String imageUrl;
  final String authorImageUrl;
  final VoidCallback onTap;

  const NewsCard({
    super.key,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.authorImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Konten Teks di Kiri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Iconsax.clock, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text('2 Hours ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const Spacer(),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: CachedNetworkImageProvider(authorImageUrl),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Iconsax.message_text_1, size: 20, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Gambar di Kanan
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}