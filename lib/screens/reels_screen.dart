import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  // Data dummy untuk video reels
  final List<Map<String, String>> reelsData = const [
    {
      "title": "Unboxing gadget terbaru yang wajib kamu punya!",
      "creator": "TechReview Indo",
      "thumbnail": "https://picsum.photos/seed/reels1/300/500",
      "views": "1.2M",
      "likes": "120K",
    },
    {
      "title": "Resep makanan viral, cuma 5 bahan!",
      "creator": "Dapur Kreatif",
      "thumbnail": "https://picsum.photos/seed/reels2/300/500",
      "views": "800K",
      "likes": "90K",
    },
    {
      "title": "Destinasi liburan tersembunyi di Indonesia",
      "creator": "Jelajah Nusantara",
      "thumbnail": "https://picsum.photos/seed/reels3/300/500",
      "views": "1.5M",
      "likes": "150K",
    },
    {
      "title": "Tips produktif ala mahasiswa top!",
      "creator": "Belajar Efektif",
      "thumbnail": "https://picsum.photos/seed/reels4/300/500",
      "views": "650K",
      "likes": "70K",
    },
    {
      "title": "Momen lucu kucing peliharaan yang bikin gemas",
      "creator": "Pecinta Kucing",
      "thumbnail": "https://picsum.photos/seed/reels5/300/500",
      "views": "2.1M",
      "likes": "200K",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black, // Background AppBar hitam untuk reels
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.camera, color: Colors.white),
            onPressed: () {
              // Aksi untuk merekam/upload reels
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.search_normal_1, color: Colors.white),
            onPressed: () {
              // Aksi untuk mencari reels
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      // Menggunakan PageView.builder untuk scrolling vertikal ala reels
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: reelsData.length,
        itemBuilder: (context, index) {
          final reel = reelsData[index];
          return _buildReelItem(context, reel);
        },
      ),
    );
  }

  Widget _buildReelItem(BuildContext context, Map<String, String> reel) {
    return Container(
      color: Colors.black, // Latar belakang hitam untuk setiap reel
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gambar Thumbnail / Video Placeholder
          CachedNetworkImage(
            imageUrl: reel['thumbnail']!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[900]),
            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
          ),

          // Overlay Gradien untuk Teks
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
          ),

          // Konten Teks dan Aksi di Kiri Bawah
          Positioned(
            bottom: 80, // Sedikit di atas BottomNavigationBar
            left: 16,
            right: 80, // Memberi ruang untuk ikon di kanan
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reel['creator']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reel['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Iconsax.eye, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      reel['views']!,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Iconsax.like_1, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      reel['likes']!,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Ikon Aksi di Kanan Bawah
          Positioned(
            bottom: 80,
            right: 16,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Iconsax.heart, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                Text('12K', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Iconsax.message_text, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                Text('234', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Iconsax.share, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                Text('87', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Iconsax.more, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}