// ignore_for_file: file_names, unnecessary_const, unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/screens/profile_edit_screen.dart';

// NOTE: This file was extended to read/update profile data from Firestore.

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab (postingan dan video)
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Sembunyikan tombol back
          // (AppBar tetap sama seperti kode Anda)
          title: const Row(
            children: [
              Text(
                'cnn.indo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              const Icon(Icons.check_circle, color: Colors.blue, size: 18),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.danger, color: Colors.black),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
          ],
        ),
        // --- PERUBAHAN DIMULAI DI SINI ---
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // Profile header will listen to Firestore for name/email
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirestoreService().streamUserProfile(FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snap) {
                        String displayName = FirebaseAuth.instance.currentUser?.email?.split('@').first ?? 'User';
                        String email = FirebaseAuth.instance.currentUser?.email ?? '';
                        if (snap.hasData && snap.data!.data() != null) {
                          final d = snap.data!.data()!;
                          displayName = (d['name'] as String?) ?? displayName;
                        }
                        return Column(
                          children: [
                            _buildProfileHeaderWithName(displayName, email),
                            _buildProfileButtons(context),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Kita pindahkan TabBar ke sini agar bisa "menempel"
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  _buildTabBar(), // Memanggil fungsi _buildTabBar() Anda
                ),
                pinned: true, // Membuat TabBar tetap di atas saat di-scroll
              ),
            ];
          },
          // TabBarView menjadi body utama, bukan di dalam Column
          body: TabBarView(
            children: [
              // Tab 1: Grid Postingan
              _buildPostsGrid(),
              // Tab 2: Grid Video (Placeholder)
              const Center(child: Text('Video Posts Grid')),
            ],
          ),
        ),
        // --- PERUBAHAN BERAKHIR DI SINI ---
      ),
    );
  }

  // --- TIDAK ADA PERUBAHAN PADA FUNGSI-FUNGSI INI ---
  // Fungsi-fungsi ini tetap sama seperti yang Anda tulis

  Widget _buildProfileHeader() {
    // kept for backward compatibility
    return _buildProfileHeaderWithName('User', '');
  }

  Widget _buildProfileHeaderWithName(String displayName, String email) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar
          CircleAvatar(
            radius: 44,
            backgroundColor: Colors.blueGrey,
            child: Text(
              displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(displayName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(email, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to edit profile screen
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileEditScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Edit Profile'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                // Optional: sign out
                await FirebaseAuth.instance.signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  // --- PERUBAHAN KECIL DI SINI ---
  // Fungsi ini sekarang mengembalikan TabBar saja, bukan Container
  TabBar _buildTabBar() {
    return const TabBar(
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(icon: const Icon(Iconsax.document)),
        Tab(icon: const Icon(Iconsax.video_play)),
      ],
    );
  }

  // Fungsi _buildPostsGrid() Anda tetap sama
  Widget _buildPostsGrid() {
    return MasonryGridView.count(
      crossAxisCount: 3, // 3 kolom
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      padding: const EdgeInsets.all(4),
      itemCount: 9, // Dummy data
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://picsum.photos/seed/post$index/300/${300 + (index % 3) * 50}', // Gambar dengan tinggi bervariasi
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 150.0 + (index % 3) * 50, // Sesuaikan tinggi placeholder
                  color: Colors.grey[200],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Iconsax.eye, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text('4445', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} // <-- Akhir dari class ProfileScreen

// --- TAMBAHKAN CLASS HELPER INI DI BAWAH CLASS ProfileScreen ---
// Class ini diperlukan untuk membuat _SliverPersistentHeader berfungsi

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Memberi background putih pada TabBar saat menempel
    return Container(
      color: Colors.white, 
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}