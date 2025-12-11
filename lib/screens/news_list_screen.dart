import 'package:flutter/material.dart';
import 'package:news_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Displays list of news from Firestore. If none, shows placeholder text.
class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _fs = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Berita')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _fs.streamNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.article, size: 64, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Belum ada berita. Tambahkan di Firestore collection `news`.')
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final data = docs[index].data();
              final title = data['title'] ?? 'No title';
              final summary = data['summary'] ?? '';
              return ListTile(
                title: Text(title),
                subtitle: Text(summary, maxLines: 2, overflow: TextOverflow.ellipsis),
              );
            },
          );
        },
      ),
    );
  }
}
