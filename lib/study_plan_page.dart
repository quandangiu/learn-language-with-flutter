import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudyPlanPage extends StatefulWidget {
  @override
  State<StudyPlanPage> createState() => _StudyPlanPageState();
}

class _StudyPlanPageState extends State<StudyPlanPage> {
  late DateTime _selectedMonth;
  late DateTime _selectedDate;
  int _studyStreak = 0;

  final List<int> _completedDays = [1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12];
  final List<int> _plannedDays = [13, 14, 15, 16, 17, 18, 19, 20];

  final List<Map<String, String>> toDoItems = [
    {
      'title': 'Vocabulary Practice',
      'duration': '20 min',
      'completed': 'true',
    },
    {
      'title': 'Speaking Practice',
      'duration': '10 min',
      'completed': 'false',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime(2024, 7);
    _selectedDate = DateTime(2024, 7, 12);
    _studyStreak = _completedDays.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Study Plan',
                      style: TextStyle(
                        color: Color(0xFF4C9BF6),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.grey[600], size: 24),
                  ],
                ),
              ),

              // Calendar Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Month navigation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
                              });
                            },
                            icon: const Icon(Icons.chevron_left, color: Color(0xFF4C9BF6)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Column(
                            children: [
                              Text(
                                DateFormat('MMMM, y').format(_selectedMonth),
                                style: const TextStyle(
                                  color: Color(0xFF4C9BF6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '20-Day Plan',
                                style: TextStyle(
                                  color: Color(0xFF1565C0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
                              });
                            },
                            icon: const Icon(Icons.chevron_right, color: Color(0xFF4C9BF6)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Calendar grid
                      _buildCalendarGrid(),
                      const SizedBox(height: 16),

                      // Study stats
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Planned Study Time',
                              '30 min',
                              Icons.schedule,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Time Studied',
                              '12 min',
                              Icons.timer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // To do list section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.checklist, color: Color(0xFF4C9BF6), size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'To do list',
                      style: TextStyle(
                        color: Color(0xFF4C9BF6),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '(6-13)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // To do items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(toDoItems.length, (index) {
                    final item = toDoItems[index];
                    final isCompleted = item['completed'] == 'true';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted ? const Color(0xFF66BB6A) : Colors.white,
                                border: Border.all(
                                  color: isCompleted ? const Color(0xFF66BB6A) : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: isCompleted
                                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] ?? '',
                                    style: TextStyle(
                                      color: const Color(0xFF4C9BF6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['duration'] ?? '',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final lastDay = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final startingDayOfWeek = firstDay.weekday;

    final dayLabels = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    return Column(
      children: [
        // Day labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: dayLabels.map((day) {
            return SizedBox(
              width: 40,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF4C9BF6),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Calendar days
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
          ),
          itemCount: startingDayOfWeek - 1 + daysInMonth,
          itemBuilder: (context, index) {
            if (index < startingDayOfWeek - 1) {
              return const SizedBox();
            }

            final day = index - startingDayOfWeek + 2;
            final isCompleted = _completedDays.contains(day);
            final isPlanned = _plannedDays.contains(day);
            final isSelected = _selectedDate.day == day;

            Color bgColor = Colors.white;
            Color textColor = const Color(0xFF1565C0);

            if (isCompleted) {
              bgColor = const Color(0xFF66BB6A);
              textColor = Colors.white;
            } else if (isPlanned) {
              bgColor = const Color(0xFF4C9BF6);
              textColor = Colors.white;
            } else if (isSelected) {
              bgColor = Colors.white;
              textColor = const Color(0xFF4C9BF6);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = DateTime(_selectedMonth.year, _selectedMonth.month, day);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  border: isSelected && !isCompleted && !isPlanned
                      ? Border.all(color: const Color(0xFF4C9BF6), width: 2)
                      : null,
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4C9BF6), size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF4C9BF6),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1565C0),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
