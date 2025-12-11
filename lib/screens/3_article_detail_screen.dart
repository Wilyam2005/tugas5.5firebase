import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String category;
  final String imageUrl;

  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Konten Scrollable (Artikel)
          CustomScrollView(
            slivers: [
              // Gambar Header
              SliverAppBar(
                expandedHeight: 300.0,
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: CachedNetworkImage(
                    imageUrl: imageUrl, // Gunakan URL gambar dari item
                    fit: BoxFit.cover,
                  ),
                ),
                // Tombol di atas (Back, Share, Comment)
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: IconButton(
                      icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(Iconsax.share, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(Iconsax.message_text, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),

              // Konten Artikel
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header (Logo, Penulis, Follow)
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.red,
                                
                                child: Text('CNN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Posted by CNN Indonesia',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text(
                                      '2 Hours ago',
                                      style: TextStyle(color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Follow'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Judul
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Tag
                          Chip(
                            label: Text(category),
                            backgroundColor: Colors.grey[200],
                            side: BorderSide.none,
                          ),
                          const SizedBox(height: 24),
                          // Isi Teks Artikel (Dummy)
                          const Text(
                            "We're gonna go hard",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Frontman Oli Sykes told NME how they're going to make their R+L set \"feel like a rollercoaster\".\n\nThe Sheffield metal titans were today confirmed to be topping the bill for the first time at the legendary twin-site event, along with fellow headliners Arctic Monkeys, Halsey, ... (dan seterusnya).",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.black87,
                            ),
                          ),
                           const SizedBox(height: 200), // Spasi agar bisa scroll ke bawah
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          // Tombol "Read More" yang Melayang
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Iconsax.document_text, size: 20),
              label: const Text('Read More'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}