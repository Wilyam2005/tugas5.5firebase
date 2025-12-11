import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/screens/3_article_detail_screen.dart'; // Import halaman detail

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  final List<String> categories = const [
    'Technology', 'Sports', 'Business', 'Entertainment', 'Health'
  ];

  final List<Map<String, String>> discoverItems = const [
    {
      "title": "House GOP uses new power in extraordinary...",
      "category": "Politics",
      "image": "https://picsum.photos/seed/discover1/400/500"
    },
    {
      "title": "Gwyneth Paltrow in court as trial over 2016 ski...",
      "category": "Breaking News",
      "image": "https://picsum.photos/seed/discover2/400/500"
    },
    {
      "title": "These iconic foods aren't as old as you think",
      "category": "Food",
      "image": "https://picsum.photos/seed/discover3/400/500"
    },
    {
      "title": "Keanu Reeves honors Lance Reddick at 'John...",
      "category": "Movies",
      "image": "https://picsum.photos/seed/discover4/400/500"
    },
    {
      "title": "Sandstorms blanket Beijing and northern Chin...",
      "category": "Breaking News",
      "image": "https://picsum.photos/seed/discover5/400/500"
    },
    {
      "title": "Bring Me The Horizon talk head lining Reading &...",
      "category": "Music",
      "image": "https://picsum.photos/seed/discover6/400/500"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        automaticallyImplyLeading: false, 
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.setting_4, color: Colors.black),
            onPressed: () {
              // Aksi filter
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategoryChips(),
          const SizedBox(height: 20),
          _buildDiscoverGrid(context),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Indonesia',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Iconsax.search_normal_1, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(categories[index]),
            backgroundColor: index == 0 ? Colors.black : Colors.white, // Chip pertama aktif
            labelStyle: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
            side: BorderSide(color: Colors.grey[300]!),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          );
        },
      ),
    );
  }

  Widget _buildDiscoverGrid(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Non-scrollable di dalam ListView
      shrinkWrap: true,
      itemCount: discoverItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 kolom
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7, // Rasio aspek kartu
      ),
      itemBuilder: (context, index) {
        final item = discoverItems[index];
        return _buildGridCard(context, item);
      },
    );
  }

  Widget _buildGridCard(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke Halaman Detail (Gambar 3)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(
              title: item['title']!,
              category: item['category']!,
              imageUrl: item['image']!,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: item['image']!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[200]),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Iconsax.document, color: Color.fromARGB(255, 69, 155, 209), size: 16),
                    ),
                  )
                ],
              ),
            ),
            // Konten Teks
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
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
                      item['category']!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Iconsax.clock, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text('2 Hours ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const Spacer(),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: CachedNetworkImageProvider(
                          'https://picsum.photos/seed/${item['title']}/50/50',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}