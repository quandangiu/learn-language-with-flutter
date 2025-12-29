import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'main_navigation.dart';
import 'learn_with_ai_page.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final User? user = _authService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue header
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF4C9BF6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (user?.photoURL != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(user!.photoURL!),
                          radius: 28,
                        )
                      else
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 28, color: Colors.blue),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ${user?.email?.split('@')[0] ?? 'User'}!',
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Let's enjoy learning English together!",
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        onPressed: () async {
                          await _authService.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Main content area
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats row
                  Row(
                    children: [
                      _statItem('Consecutive Study', '15\nDays'),
                      Container(width: 1, height: 48, color: Colors.grey[200]),
                      _statItem('Total Study', '30\nhours'),
                      Container(width: 1, height: 48, color: Colors.grey[200]),
                      _statItem('Completed', '8\nCourses'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 12),
                  
                  // Today section with icon
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.calendar_today, color: Color(0xFF4C9BF6), size: 24),
                        ),
                        const SizedBox(height: 6),
                        const Text('Today', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4C9BF6), fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  
                  // Points and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('8 points', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green, fontSize: 13)),
                      Text('12 min / 30 min', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.4,
                      minHeight: 10,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF66BB6A)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Current Study Courses
                  const Text('Current Study Courses', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1565C0))),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey[200]!),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'anh/1.png',
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Icon(Icons.image, size: 40, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Grocery Shopping', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1565C0))),
                                const SizedBox(height: 6),
                                const Text(
                                  'In a grocery store, students learn how to ask about prices, locate items, and discuss payment methods.',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text('Daily Life', style: TextStyle(fontSize: 11, color: Color(0xFF1565C0), fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Recommended Study Courses
                  const Text('Recommended Study Courses', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1565C0))),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _courseCard(context, 'anh/2.png', 'Classroom Interaction'),
                        const SizedBox(width: 10),
                        _courseCard(context, 'anh/3.png', 'Airport Security Check'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Learn with AI section
                  const Text('Learn with AI', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1565C0))),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LearnWithAIPage(
                            title: 'Grocery Shopping',
                            imagePath: 'anh/1.png',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'anh/1.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Icon(Icons.image, size: 30, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Chat with AI Assistant',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1565C0)),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Practice real conversations with our AI tutor',
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Color(0xFF4C9BF6)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF1565C0), fontSize: 11, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1565C0))),
        ],
      ),
    );
  }

  Widget _courseCard(BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LearnWithAIPage(
              title: title,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          width: 140,
          height: 110,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 140,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
