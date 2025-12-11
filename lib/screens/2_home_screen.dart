import 'package:flutter/material.dart';
import 'package:news_app/screens/3_article_detail_screen.dart'; // Import halaman detail
import 'package:news_app/widgets/news_card.dart'; // Kita akan buat widget ini
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/services/firestore_service.dart';
import 'package:news_app/screens/news_list_screen.dart';
import 'package:news_app/screens/4_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Data dummy untuk kategori
  final List<String> categories = const [
    'Technology', 'Sports', 'Business', 'Entertainment', 'Health'
  ];

  // Data dummy untuk daftar berita
  final List<Map<String, String>> newsFeedItems = const [
    {
      "title": "Bring Me The Horizon talk head lining Reading &...",
      "category": "Music",
      "image": "https://picsum.photos/seed/news1/400/300",
      "authorImage": "https://picsum.photos/seed/author1/50/50"
    },
    {
      "title": "Google was beloved as an employer for years. Then...",
      "category": "Technology",
      "image": "https://picsum.photos/seed/news2/400/300",
      "authorImage": "https://picsum.photos/seed/author2/50/50"
    },
    {
      "title": "London's Metropolitan Police lets predators...",
      "category": "Breaking News",
      "image": "https://picsum.photos/seed/news3/400/300",
      "authorImage": "https://picsum.photos/seed/author3/50/50"
    },
    {
      "title": "Biden administration demands TikTok's Chines...",
      "category": "Technology",
      "image": "https://picsum.photos/seed/news4/400/300",
      "authorImage": "https://picsum.photos/seed/author4/50/50"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final fs = FirestoreService();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Portal Berita', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Greeting
          StreamBuilder(
            stream: user != null ? fs.streamUserProfile(user.uid) : null,
            builder: (context, AsyncSnapshot snapshot) {
              String name = user?.email?.split('@').first ?? 'User';
              if (snapshot.hasData && snapshot.data.data() != null) {
                final d = snapshot.data.data() as Map<String, dynamic>?;
                if (d != null && d['name'] != null) name = d['name'] as String;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo, $name', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewsListScreen())),
                        icon: const Icon(Icons.article),
                        label: const Text('Daftar Berita'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                        icon: const Icon(Icons.person),
                        label: const Text('Profil'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),

          // News feed UI below
          _buildCategoryHeader(context),
          _buildCategoryChips(),
          const SizedBox(height: 10),
          _buildNewsFeedList(),
        ],
      ),
    );
  }

  // Widget untuk "Category News" dan "View All"
  Widget _buildCategoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Category News',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'View All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Chip Kategori (Sama seperti halaman Discover)
  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(categories[index]),
            backgroundColor: index == 0 ? Colors.black : Colors.white,
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

  // Widget untuk daftar berita
  Widget _buildNewsFeedList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: newsFeedItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = newsFeedItems[index];
        return NewsCard(
          title: item['title']!,
          category: item['category']!,
          imageUrl: item['image']!,
          authorImageUrl: item['authorImage']!,
          onTap: () {
            // Navigasi ke Halaman Detail (Gambar 3)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  title: item['title']!,
                  category: item['category']!,
                  imageUrl: 'https://picsum.photos/seed/bmth/600/400', // Ganti dengan gambar spesifik
                ),
              ),
            );
          },
        );
      },
    );
  }
}