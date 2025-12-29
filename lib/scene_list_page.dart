import 'package:flutter/material.dart';
import 'scene_detail_page.dart';

class SceneListPage extends StatefulWidget {
  @override
  State<SceneListPage> createState() => _SceneListPageState();
}

class _SceneListPageState extends State<SceneListPage> {
  final TextEditingController _searchController = TextEditingController();
  
  final List<Map<String, String>> scenes = [
    {
      'title': 'Grocery Shopping',
      'description': 'In a grocery store, students learn how to ask about prices, locate items, and discuss payment methods.',
      'tag': 'Daily Life',
      'image': 'anh/1.png',
    },
    {
      'title': 'Classroom Interaction',
      'description': 'In the classroom, students learn how to answer teacher questions, discuss with classmates, and express their opinions.',
      'tag': 'School Life',
      'image': 'anh/2.png',
    },
    {
      'title': 'Airport Security Check',
      'description': 'At the airport security check, students learn how to answer questions at the security checkpoint and communicate with staff.',
      'tag': 'Travel',
      'image': 'anh/3.png',
    },
    {
      'title': 'Birthday Party',
      'description': 'At a birthday party, students learn to congratulate the birthday person, express good wishes, and engage in casual conversation.',
      'tag': 'Social Events',
      'image': 'anh/4.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Scene Learning', style: TextStyle(color: Color(0xFF4C9BF6), fontWeight: FontWeight.w700, fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Scenes',
                    hintStyle: const TextStyle(color: Color(0xFFB0BED9), fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFB0BED9)),
                    suffixIcon: const Icon(Icons.filter_list, color: Color(0xFF4C9BF6)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                ),
              ),
            ),

            // Grid of scenes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                ),
                itemCount: scenes.length,
                itemBuilder: (context, index) {
                  final scene = scenes[index];
                  return _sceneCard(scene);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sceneCard(Map<String, String> scene) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SceneDetailPage(
              title: scene['title'] ?? '',
              imagePath: scene['image'] ?? 'anh/1.png',
              tag: scene['tag'] ?? '',
              description: scene['description'] ?? '',
            ),
          ),
        );
      },
      child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              scene['image'] ?? 'anh/1.png',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    color: Colors.grey[300],
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  scene['title'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1565C0)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    scene['description'] ?? '',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    scene['tag'] ?? '',
                    style: const TextStyle(fontSize: 9, color: Color(0xFF1565C0), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
