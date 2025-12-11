import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  // Data dummy untuk daftar chat/pesan
  final List<Map<String, String>> chatData = const [
    {
      "name": "Alex Smith",
      "lastMessage": "Oke, saya akan segera kirim detailnya.",
      "time": "2 menit lalu",
      "avatar": "https://picsum.photos/seed/alex/50/50",
      "unread": "2"
    },
    {
      "name": "Jane Doe",
      "lastMessage": "Jangan lupa rapat jam 10 pagi.",
      "time": "15 menit lalu",
      "avatar": "https://picsum.photos/seed/jane/50/50",
      "unread": ""
    },
    {
      "name": "Team Project X",
      "lastMessage": "Pembahasan final untuk deadline besok.",
      "time": "1 jam lalu",
      "avatar": "https://picsum.photos/seed/team/50/50",
      "unread": "5"
    },
    {
      "name": "Marketing Dept.",
      "lastMessage": "Laporan bulanan sudah siap.",
      "time": "Kemarin",
      "avatar": "https://picsum.photos/seed/marketing/50/50",
      "unread": ""
    },
    {
      "name": "Customer Support",
      "lastMessage": "Terima kasih atas feedback Anda.",
      "time": "2 hari lalu",
      "avatar": "https://picsum.photos/seed/support/50/50",
      "unread": ""
    },
    {
      "name": "John Legend",
      "lastMessage": "Bagaimana progressnya?",
      "time": "3 hari lalu",
      "avatar": "https://picsum.photos/seed/john/50/50",
      "unread": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal_1, color: Colors.black),
            onPressed: () {
              // Aksi untuk mencari chat
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.add_square, color: Colors.black),
            onPressed: () {
              // Aksi untuk membuat chat baru
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: chatData.length,
        separatorBuilder: (context, index) => const Divider(indent: 72, height: 0),
        itemBuilder: (context, index) {
          final chat = chatData[index];
          return _buildChatItem(context, chat);
        },
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Map<String, String> chat) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: CachedNetworkImageProvider(chat['avatar']!),
      ),
      title: Text(
        chat['name']!,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(
        chat['lastMessage']!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey[600], fontSize: 14),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat['time']!,
            style: TextStyle(
              fontSize: 12,
              color: chat['unread']!.isNotEmpty ? Colors.black : Colors.grey,
            ),
          ),
          if (chat['unread']!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Text(
                chat['unread']!,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        // Aksi ketika item chat diklik (misal: buka halaman chat detail)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Membuka chat dengan ${chat['name']}')),
        );
      },
    );
  }
}