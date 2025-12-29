import 'package:flutter/material.dart';

class SceneDetailPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final String tag;
  final String? description;

  const SceneDetailPage({
    required this.title,
    required this.imagePath,
    required this.tag,
    this.description,
  });

  @override
  State<SceneDetailPage> createState() => _SceneDetailPageState();
}

enum PageState { intro, practice, result }

class _SceneDetailPageState extends State<SceneDetailPage> {
  PageState _pageState = PageState.intro;
  int _score = 0;
  int _currentStep = 0;
  double _rating = 0;

  final List<Map<String, String>> dialogues = [
    {
      'type': 'ST',
      'text': 'Excuse me, can you help me find the apples?',
      'speaker': 'Student',
    },
    {
      'type': 'SA',
      'text': 'Sure! The apples are in aisle 5.',
      'speaker': 'Shop Assistant',
    },
    {
      'type': 'ST',
      'text': 'Thank you! How much do they cost?',
      'speaker': 'Student',
    },
    {
      'type': 'SA',
      'text': 'They are \$2.99 per pound.',
      'speaker': 'Shop Assistant',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_pageState == PageState.intro) {
      return _buildIntroPage();
    } else if (_pageState == PageState.result) {
      return _buildResultPage();
    }
    return _buildPracticePage();
  }

  Widget _buildIntroPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4C9BF6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Color(0xFF4C9BF6), fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.tag,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF1565C0), fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 80, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1565C0))),
                  const SizedBox(height: 8),
                  Text(
                    'In a grocery store, students learn how to ask about prices, locate items, and discuss payment methods.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Beginner',
                      style: TextStyle(fontSize: 10, color: Color(0xFF1565C0), fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Estimated time:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1565C0))),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, strokeAlign: BorderSide.strokeAlignInside),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '5 minutes',
                      style: TextStyle(fontSize: 13, color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Dialogue Preview:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1565C0))),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, strokeAlign: BorderSide.strokeAlignInside),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Emma: Excuse me, can you help me find the apples?',
                          style: TextStyle(fontSize: 12, color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Salesperson: Sure! The apples are in aisle 5.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Emma: Thank you. How much do they cost?',
                          style: TextStyle(fontSize: 12, color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Salesperson: They are \$2 per pound.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'More...',
                            style: TextStyle(fontSize: 11, color: Color(0xFF4C9BF6), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _pageState = PageState.practice;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C9BF6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Start Practice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
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

  Widget _buildResultPage() {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4C9BF6), width: 3),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Save Progress',
                      style: TextStyle(
                        color: Color(0xFF4C9BF6),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your progress has been saved. You can continue from where you left off next time.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1565C0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _pageState = PageState.intro;
                                _currentStep = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF66BB6A),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF66BB6A),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Exit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPracticePage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4C9BF6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Color(0xFF4C9BF6), fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.tag,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF1565C0), fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 80, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Practice Dialogue', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF1565C0))),
                  const SizedBox(height: 12),
                  ...List.generate(_currentStep + 1, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildDialogueBubble(dialogues[index]),
                    );
                  }),
                  const SizedBox(height: 24),
                  const Text('Your Response', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF1565C0))),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.mic, color: Color(0xFF4C9BF6), size: 24),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Record your response', style: TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('Tap microphone to record', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _currentStep < dialogues.length - 1
                            ? () {
                                setState(() {
                                  _currentStep++;
                                  _rating = 0;
                                });
                              }
                            : () {
                                setState(() {
                                  _pageState = PageState.result;
                                  _score = 85;
                                });
                              },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4C9BF6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mic, color: Colors.white, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _currentStep > 0
                            ? () {
                                setState(() {
                                  _currentStep--;
                                  _rating = 0;
                                });
                              }
                            : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentStep > 0 ? Colors.white : Colors.grey[300],
                            side: BorderSide(color: _currentStep > 0 ? Colors.grey[300]! : Colors.transparent),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: Text('Previous', style: TextStyle(color: _currentStep > 0 ? Colors.grey : Colors.grey[600], fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _currentStep < dialogues.length - 1
                            ? () {
                                setState(() {
                                  _currentStep++;
                                  _rating = 0;
                                });
                              }
                            : () {
                                setState(() {
                                  _pageState = PageState.result;
                                  _score = 85;
                                });
                              },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4C9BF6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            _currentStep < dialogues.length - 1 ? 'Next' : 'Finish',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildDialogueBubble(Map<String, String> dialogue) {
    final isStudent = dialogue['type'] == 'ST';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isStudent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isStudent) ...[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4C9BF6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                dialogue['type'] ?? '',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isStudent ? const Color(0xFFE3F2FD) : const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: isStudent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  dialogue['text'] ?? '',
                  style: const TextStyle(color: Color(0xFF1565C0), fontSize: 13),
                ),
                if (isStudent)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _rating = (i + 1).toDouble();
                            });
                          },
                          child: Icon(
                            Icons.star,
                            color: i < _rating ? Colors.orange : Colors.grey[300],
                            size: 18,
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (isStudent) ...[
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4C9BF6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                dialogue['type'] ?? '',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
