import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'scene_list_page.dart';
import 'study_plan_page.dart';
import 'profile_page.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    HomeScreen(),
    SceneListPage(),
    StudyPlanPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 0, 'Home'),
            _navItem(Icons.book, 1, 'Books'),
            _navItem(Icons.calendar_today, 2, 'Calendar'),
            _navItem(Icons.person, 3, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index, String label) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Icon(
              icon,
              color: _selectedIndex == index ? const Color(0xFF4C9BF6) : Colors.grey,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
